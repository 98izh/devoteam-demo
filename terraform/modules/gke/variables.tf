variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for the cluster"
  type        = string
}

variable "node_locations" {
  description = "Zones for the regional cluster node pools"
  type        = list(string)
}

variable "network_self_link" {
  description = "Self link of the VPC network"
  type        = string
}

variable "subnetwork_self_link" {
  description = "Self link of the private subnet"
  type        = string
}

variable "pods_secondary_range_name" {
  description = "Name of the secondary IP range for Pods"
  type        = string
  default     = "192.168.8.0/22"
}

variable "services_secondary_range_name" {
  description = "Name of the secondary IP range for Services"
  type        = string
}

variable "bastion_subnet_cidr" {
  description = "CIDR block for the bastion subnet"
  type        = string
}