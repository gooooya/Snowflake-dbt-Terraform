resource "snowflake_database_role" "this" {
  for_each = { for r in distinct(var.roles) : "${r.database_name}_${r.database_role_name}" => r }

  database = each.value.database_name
  name = each.value.database_role_name
}
# TODO:commentの追加。distinctできなくなるためいったん削除している。
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/database_role