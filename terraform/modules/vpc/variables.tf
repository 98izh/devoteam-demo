variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "mgmt_subnet_cidr" {
  description = "CIDR block for the management subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "pods_secondary_range" {
  description = "Secondary IP range name for Pods"
  type        = string
}

variable "pods_secondary_cidr" {
  description = "CIDR block for Pods secondary range"
  type        = string
}

variable "services_secondary_range" {
  description = "Secondary IP range name for Services"
  type        = string
}

variable "services_secondary_cidr" {
  description = "CIDR block for Services secondary range"
  type        = string
}