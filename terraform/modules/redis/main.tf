resource "google_redis_instance" "redis_ha" {
  name                    = "redis-ha"
  project                 = var.project_id
  region                  = var.region
  tier                    = var.tier
  memory_size_gb          = var.memory_size_gb
  authorized_network      = var.authorized_network
  redis_version           = "REDIS_7_0"
  location_id             = var.primary_zone
  alternative_location_id = var.failover_zone
}