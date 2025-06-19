provider "google" {
  project = var.project_id
  region  = var.region
}

module "vpc" {
  source                   = "../../modules/vpc"
  project_id               = var.project_id
  region                   = var.region
  vpc_name                 = "devo-vpc"
  mgmt_subnet_cidr         = "192.168.1.0/24"
  private_subnet_cidr      = "192.168.2.0/24"
  pods_secondary_range     = "pods"
  pods_secondary_cidr      = "192.168.8.0/22"
  services_secondary_range = "services"
  services_secondary_cidr  = "192.168.4.0/24"
}

module "bastion" {
  source                = "../../modules/bastion"
  project_id            = var.project_id
  region                = var.region
  zone                  = element(var.node_locations, 0)
  mgmt_subnet_self_link = module.vpc.mgmt_subnet_self_link
  bastion_internal_ip   = "192.168.1.10"
  bastion_name          = "bastion-vm"
  machine_type          = "e2-medium"
}

module "gke" {
  source                        = "../../modules/gke"
  project_id                    = var.project_id
  region                        = var.region
  node_locations                = var.node_locations
  network_self_link             = module.vpc.network_self_link
  subnetwork_self_link          = module.vpc.private_subnet_self_link
  pods_secondary_range_name     = module.vpc.pods_secondary_range
  services_secondary_range_name = module.vpc.services_secondary_range
  bastion_subnet_cidr           = module.vpc.mgmt_subnet_cidr
}

module "redis" {
  source             = "../../modules/redis"
  project_id         = var.project_id
  region             = var.region
  primary_zone       = var.node_locations[0]
  failover_zone      = var.node_locations[1]
  tier               = var.redis_tier
  memory_size_gb     = var.redis_memory_size_gb
  authorized_network = module.vpc.network_self_link
}

#module "monitoring" {
#  source     = "../../modules/monitoring"
#  project_id = var.project_id
#  host       = var.app_host
#  email      = var.alert_email
#}

module "iam" {
  source     = "../../modules/iam"
  project_id = var.project_id
  reviewer_principals = [
    "user:atef.mahmoud@devoteam.com"
  ]
}