resource "snowflake_storage_integration" "this" {
  name = var.storage_integration.name
  type = var.storage_integration.type
  storage_provider = var.storage_integration.storage_provider
  enabled = var.storage_integration.enabled
  storage_allowed_locations = var.storage_integration.storage_allowed_locations
}