resource "snowflake_grant_database_role" "g" {
  for_each = { for g in var.relation : "${g.database_role_name}_${g.parent_role_name}" => g }
  
  database_role_name = each.value.database_role_name
  parent_role_name = each.value.parent_role_name
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_database_role