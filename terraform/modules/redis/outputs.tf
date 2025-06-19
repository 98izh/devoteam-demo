output "redis_host" {
  description = "Private IP of Redis primary"
  value       = google_redis_instance.redis_ha.host
}