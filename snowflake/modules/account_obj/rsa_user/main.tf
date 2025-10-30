locals {
  users_map = tomap({
    for u in nonsensitive(var.users) : u.name => u
  })
}

resource "snowflake_user" "airflow_user" {
  for_each = local.users_map

  name = each.value.name
  login_name = each.value.login_name
  password = each.value.password
  rsa_public_key = each.value.rsa_public_key
  default_role = each.value.default_role
  default_warehouse = each.value.default_warehouse
  default_namespace = each.value.default_namespace
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/user