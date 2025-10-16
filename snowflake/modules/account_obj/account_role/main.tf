resource "snowflake_account_role" "this" {
  for_each = { for r in var.roles : r.name => r }

  name = each.value.name
  comment = each.value.comment
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/account_role