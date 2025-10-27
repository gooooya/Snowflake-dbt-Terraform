resource "snowflake_grant_privileges_to_database_role" "this" {
  for_each = { for this in var.relation : "${this.database_role_name}_${this.on_database}" => this }
  
  privileges = each.value.privileges
  database_role_name = "${each.value.on_database}.${each.value.database_role_name}"
  on_schema {
    schema_name = "${each.value.on_database}.${each.value.on_schema}"
  }
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/grant_privileges_to_database_role