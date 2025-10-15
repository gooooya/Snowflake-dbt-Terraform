resource "snowflake_database" "this" {
  for_each = { for r in var.databases : r.name => r }

  name = each.value.name
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/database