resource "snowflake_stage" "s3_stage" {
  name = var.stage.name
  database = var.stage.database
  schema = var.stage.schema
  url = var.stage.s3_url
  storage_integration = var.stage.storage_integration
  encryption = "TYPE = '${var.stage.encryption}'"
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/pipe