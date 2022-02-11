terraform {
  backend "gcs" {
  }
}


locals {
  default_tags = tomap({
    "env"     = var.environment
    "user"    = var.user
    "region"  = var.region
    "cohort"  = format("ce%02d", var.cohort)
    "Purpose" = var.application
    "usage"   = "ansible"
    }
  )
}

data "local_file" "public_key_file" {
  filename = var.public_key_file
}


module "add_ansible_user" {
  source              = "git::https://kubrick-training@dev.azure.com/kubrick-training/ce02/_git/terraform-kubrick-ubuntu_first_boot?ref=ce02_terraform-kubrick-ubuntu_first_boot_20220104.3"
  user                = var.ansible_username
  ssh_public_key_file = var.ansible_public_key_file
}


module "linux_vm" {
  source                  = "git::https://kubrick-training@dev.azure.com/kubrick-training/ce02/_git/terraform-kubrick-gcp_ubuntu_vm_iceberg?ref=take2" #?ref=take2 #"git::https://kubrick-training@dev.azure.com/kubrick-training/ce02/_git/terraform-kubrick-gcp_ubuntu_vm?ref=ce02_terraform-kubrick-gcp_ubuntu_vm_20220104.1"
  count                   = 1
  vmid                    = count.index
  admin_name              = var.admin_name
  public_key_filename     = abspath(var.public_key_file)
  region                  = var.region
  metadata_startup_script = module.add_ansible_user.raw
  environment             = var.environment
  user                    = var.ansible_username
  cohort                  = var.cohort
  application             = var.application
  depends_on = [
    module.add_ansible_user
  ]
}