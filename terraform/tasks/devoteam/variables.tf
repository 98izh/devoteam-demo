variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "devoteam-463111"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "me-central1"
}

variable "node_locations" {
  description = "Zones for the regional GKE node pools"
  type        = list(string)
  default     = ["me-central1-a", "me-central1-b", "me-central1-c"]
}

variable "redis_memory_size_gb" {
  description = "Size in GB for the Redis instance"
  type        = number
  default     = 2
}
variable "redis_tier" {
  description = "Memorystore tier"
  type        = string
  default     = "STANDARD_HA"
}
variable "redis_primary_zone" {
  description = "Primary zone for Redis"
  type        = string
}
variable "redis_failover_zone" {
  description = "Secondary zone for Redis failover"
  type        = string
}

#variable "app_host" {
#  description = "Public host or IP of the application load balancer"
#  type        = string
#  default     = "REPLACE_WITH_YOUR_APP_HOST"
#}
#variable "alert_email" {
#  description = "Email to notify on app downtime"
#  type        = string
#  default     = "you@example.com"
#}