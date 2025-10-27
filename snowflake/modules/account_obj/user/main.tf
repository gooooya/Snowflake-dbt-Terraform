resource "snowflake_user" "users" {
  for_each = { for u in var.users : u.name => u }

  name = each.value.name
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/user
# TODO:default使えばrsa_userと統合できるはず？