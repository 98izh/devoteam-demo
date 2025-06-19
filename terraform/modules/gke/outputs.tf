output "cluster_name" {
  description = "Name of the GKE cluster"
  value       = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  description = "Endpoint for the GKE control plane"
  value       = google_container_cluster.primary.endpoint
}

output "node_pool_name" {
  description = "Name of the primary node pool"
  value       = google_container_node_pool.primary_nodes.name
}