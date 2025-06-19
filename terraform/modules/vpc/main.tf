resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "mgmt" {
  name          = "${var.vpc_name}-mgmt"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.mgmt_subnet_cidr
  network       = google_compute_network.vpc.id
}

resource "google_compute_subnetwork" "private" {
  name                     = "${var.vpc_name}-private"
  project                  = var.project_id
  region                   = var.region
  ip_cidr_range            = var.private_subnet_cidr
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = var.pods_secondary_range
    ip_cidr_range = var.pods_secondary_cidr
  }
  secondary_ip_range {
    range_name    = var.services_secondary_range
    ip_cidr_range = var.services_secondary_cidr
  }
}

resource "google_compute_router" "nat_router" {
  name    = "${var.vpc_name}-nat-router"
  project = var.project_id
  region  = var.region
  network = google_compute_network.vpc.id
}

resource "google_compute_router_nat" "nat_config" {
  name                               = "${var.vpc_name}-nat"
  project                            = var.project_id
  region                             = var.region
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

# Allow only IAP TCP-forwarded SSH to the bastion
resource "google_compute_firewall" "allow_ssh_iap" {
  name    = "${var.vpc_name}-fw-ssh-iap"
  project = var.project_id
  network = google_compute_network.vpc.id

  direction = "INGRESS"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["bastion"]
}

# Allow egress from private nodes only
resource "google_compute_firewall" "allow_private_egress" {
  name    = "${var.vpc_name}-fw-private-egress"
  project = var.project_id
  network = google_compute_network.vpc.id

  direction = "EGRESS"
  allow {
    protocol = "all"
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags        = ["private-nodes"]
}