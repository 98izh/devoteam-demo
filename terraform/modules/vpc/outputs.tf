output "network_self_link" {
  description = "Self link of the VPC network"
  value       = google_compute_network.vpc.self_link
}

output "mgmt_subnet_self_link" {
  description = "Self link of the management subnet"
  value       = google_compute_subnetwork.mgmt.self_link
}

output "private_subnet_self_link" {
  description = "Self link of the private subnet"
  value       = google_compute_subnetwork.private.self_link
}

output "pods_secondary_range" {
  description = "Pods secondary range name"
  value       = var.pods_secondary_range
}

output "services_secondary_range" {
  description = "Services secondary range name"
  value       = var.services_secondary_range
}

output "mgmt_subnet_cidr" {
  description = "CIDR of the management subnet"
  value       = var.mgmt_subnet_cidr
}