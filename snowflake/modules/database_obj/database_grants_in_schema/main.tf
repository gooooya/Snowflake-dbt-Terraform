# all in schema
resource "snowflake_grant_privileges_to_database_role" "this" {
  for_each = { for idx, r in var.grants : "${r.database_role_name}_${idx}" => r }

  privileges = each.value.privileges
  database_role_name = each.value.database_role_name
  on_schema_object {
    all {
      object_type_plural = each.value.object_type_plural
      in_schema = each.value.in_schema
    }
  }
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/2.8.0/docs/resources/grant_privileges_to_database_role