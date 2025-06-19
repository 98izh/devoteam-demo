// Service Accounts
resource "google_service_account" "terraform" {
  account_id   = "terraform-sa"
  project      = var.project_id
  display_name = "Terraform Automation Service Account"
}

resource "google_service_account" "github_runner" {
  account_id   = "github-ci-sa"
  project      = var.project_id
  display_name = "GitHub Actions Runner Service Account"
}

resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes-sa"
  project      = var.project_id
  display_name = "GKE Node Pool Service Account"
}

// IAM Bindings (least privilege)
locals {
  terraform_roles = [
    "roles/container.admin",         // GKE admin
    "roles/compute.networkAdmin",    // VPC & firewall
    "roles/iam.serviceAccountUser",  // Impersonate SAs
    "roles/secretmanager.admin",     // Secrets
    "roles/monitoring.editor",       // Alerts & uptime checks
    "roles/redis.admin",             // Memorystore
    "roles/artifactregistry.writer", // Push images
  ]
}

resource "google_project_iam_member" "terraform_bindings" {
  for_each = toset(local.terraform_roles)
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.terraform.email}"
}

locals {
  reviewer_roles = [
    "roles/compute.viewer",       // view VMs, networks
    "roles/container.viewer",     // view GKE clusters
    "roles/redis.viewer",         // view Memorystore
    "roles/monitoring.viewer",    // view uptime checks & alerts
    "roles/secretmanager.viewer", // view secrets metadata (no access to secret data)
  ]
  // Build a flat list of { principal, role } maps
  reviewer_bindings = flatten([
    for principal in var.reviewer_principals : [
      for role in local.reviewer_roles : {
        principal = principal
        role      = role
      }
    ]
  ])
}

// Create one IAM binding per (principal, role) pair
resource "google_project_iam_member" "reviewers" {
  for_each = {
    for b in local.reviewer_bindings :
    "${replace(b.principal, ":[^A-Za-z0-9._-]", "-")}-${replace(b.role, "/", "-")}" => b
  }

  project = var.project_id
  role    = each.value.role
  member  = each.value.principal
}