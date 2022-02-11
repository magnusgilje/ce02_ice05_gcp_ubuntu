output "ip_address" {
  description = "Private IP Address"

  value = google_compute_instance.linux_vm.network_interface.0.network_ip
}