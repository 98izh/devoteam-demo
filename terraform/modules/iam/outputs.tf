output "terraform_sa_email" {
  description = "Email of Terraform Service Account"
  value       = google_service_account.terraform.email
}

output "github_runner_sa_email" {
  description = "Email of GitHub Actions SA"
  value       = google_service_account.github_runner.email
}

output "gke_nodes_sa_email" {
  description = "Email of GKE Node Pool SA"
  value       = google_service_account.gke_nodes.email
}