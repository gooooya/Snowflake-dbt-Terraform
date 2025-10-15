resource "snowflake_grant_database_role" "g" {

  for_each = { for g in var.relation : "${g.database_role_name}_${g.account_role_name}" => g }
  
  database_role_name = each.value.database_role_name
  parent_role_name = each.value.account_role_name
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_database_role


# future in schema
resource "snowflake_grant_privileges_to_database_role" "this" {
  for_each = { for idx, r in var.grants : "${r.database_role_name}_${idx}" => r }

  privileges = each.value.privileges
  database_role_name = "${each.value.database_name}.${each.value.database_role_name}"
  on_schema_object {
    all {
      object_type_plural = each.value.object_type_plural
      in_schema = "${each.value.database_name}.${each.value.in_schema}"
    }
  }
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_privileges_to_account_role