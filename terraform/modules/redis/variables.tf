variable "project_id" {
  type = string
}
variable "region" {
  type = string
}
variable "primary_zone" {
  description = "Primary zone for Redis instance"
  type        = string
}
variable "failover_zone" {
  description = "Secondary zone for HA"
  type        = string
}
variable "tier" {
  description = "Memorystore tier"
  type        = string
}
variable "memory_size_gb" {
  description = "Memory size in GB"
  type        = number
}
variable "authorized_network" {
  description = "Self-link of the VPC network"
  type        = string
}