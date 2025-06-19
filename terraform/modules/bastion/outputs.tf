output "bastion_self_link" {
  description = "Self link of the Bastion VM"
  value       = google_compute_instance.bastion.self_link
}

output "bastion_internal_ip" {
  description = "Internal IP of the Bastion VM"
  value       = google_compute_instance.bastion.network_interface[0].network_ip
}