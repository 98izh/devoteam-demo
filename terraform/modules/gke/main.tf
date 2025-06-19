resource "google_container_cluster" "primary" {
  name                     = "devo-regional-private"
  project                  = var.project_id
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network_self_link
  subnetwork = var.subnetwork_self_link

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "192.168.5.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.bastion_subnet_cidr
      display_name = "bastion-subnet"
    }
  }

  node_locations = var.node_locations

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = "REGULAR"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name     = "devo-node-pool"
  project  = var.project_id
  location = var.region
  cluster  = google_container_cluster.primary.name

  node_locations = var.node_locations

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 50
    tags         = ["private-nodes"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    # default node service account is used; customize if desired
  }
}