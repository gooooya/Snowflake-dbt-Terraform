resource "snowflake_grant_privileges_to_account_role" "this" {
  for_each = { for g in var.grants : "${g.account_role_name}_${g.object_name}" => g }
  
  account_role_name = each.value.account_role_name
  privileges = each.value.privileges
  on_account_object {
    object_type = each.value.object_type
    object_name = each.value.object_name
  }
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/2.9.0/docs/resources/grant_privileges_to_account_role#object_type-2