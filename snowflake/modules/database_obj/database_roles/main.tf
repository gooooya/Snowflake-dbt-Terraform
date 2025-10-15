resource "snowflake_database_role" "this" {
  for_each = {for r in var.roles : r.database_role_name => r}

  database = each.value.database_name
  name = each.value.database_role_name
  comment  = each.value.comment
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/database_role
