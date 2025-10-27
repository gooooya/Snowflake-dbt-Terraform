resource "snowflake_grant_account_role" "g" {
  for_each = { for g in var.grants : "${g.role_name}_${g.user_name}" => g }
  
  role_name = each.value.role_name
  user_name = each.value.user_name
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_account_role