resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
       image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    subnetwork = var.mgmt_subnet_self_link
    network_ip = var.bastion_internal_ip
  }

  tags = ["bastion"]

  metadata = {
    enable-oslogin = "TRUE"
  }
}