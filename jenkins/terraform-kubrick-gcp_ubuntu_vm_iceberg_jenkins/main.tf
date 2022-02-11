# data "aws_subnet" "subnet" {
#   id = var.subnet_id
# }


locals {
  instance            = format("%03d", var.vmid)
  vm_name             = format("vm%s%s%03d", var.user, var.application, local.instance)
  security_group_name = format("%s-ssh-sg", local.vm_name)

  default_tags = tomap({
    "env"      = var.environment,
    "user"     = var.user,
    "cohort"   = var.cohort,
    "region"   = var.region,
    "cohort"   = format("ce%02d", var.cohort),
    "Purpose"  = var.application,
    "usage"    = "ubuntu",
    "platform" = "gcp",
    "OS"       = "Linux"
    }
  )
}



# resource "aws_network_interface" "linux_vm" {
#   subnet_id   = var.subnet_id
# }

data "local_file" "pub" {
  filename = var.public_key_filename
}

resource "google_compute_instance" "linux_vm" {
  name         = local.vm_name
  machine_type = var.size
  zone         = var.region

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }


  metadata = {
    ssh-keys = format("%s:%s", var.admin_name, data.local_file.pub.content)
  }

  metadata_startup_script = var.metadata_startup_script



  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }
  // Apply the firewall rule to allow external IPs to access this instance
  # tags = [local.default_tags]
}
