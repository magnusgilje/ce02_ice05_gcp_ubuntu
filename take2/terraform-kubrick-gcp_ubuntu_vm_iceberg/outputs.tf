output "ip_address" {
  description = "Public IP Address"

  value = google_compute_instance.linux_vm.network_interface.0.access_config.0.nat_ip
}