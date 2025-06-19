variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "zone" {
  description = "Zone for the Bastion VM"
  type        = string
}

variable "mgmt_subnet_self_link" {
  description = "Self link of the management subnet"
  type        = string
}

variable "bastion_internal_ip" {
  description = "Internal IP address for Bastion VM"
  type        = string
}

variable "bastion_name" {
  description = "Name of the Bastion VM"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the Bastion VM"
  type        = string
}