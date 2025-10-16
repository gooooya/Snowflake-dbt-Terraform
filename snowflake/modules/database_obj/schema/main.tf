resource "snowflake_schema" "schema" {
  for_each = { for s in var.relation : "${s.database_name}_${s.schema_name}" => s }

  name = each.value.schema_name
  database = each.value.database_name
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/schema