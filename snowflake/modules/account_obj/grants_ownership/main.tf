resource "snowflake_grant_ownership" "this" {
  for_each = { for g in var.grants_ownership : "${g.account_role_name}_${g.object_name}" => g }
  
  account_role_name = each.value.account_role_name
  outbound_privileges = each.value.outbound_privileges
  on {
    object_type = each.value.object_type
    object_name = each.value.object_name
  }
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_ownership