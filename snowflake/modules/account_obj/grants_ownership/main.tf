resource "snowflake_grant_ownership" "this" {
  for_each = { for g in var.grants_ownership : g.object_type => g }
  
  account_role_name = each.value.account_role_name
  outbound_privileges = "REVOKE"
  on {
    object_type = each.value.object_type
    object_name = each.value.object_name
  }
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_ownership