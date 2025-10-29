resource "snowflake_table" "this" {
  for_each = { for r in var.relation : r.name => r }

  name     = each.value.name
  database = each.value.database
  schema   = each.value.schema

  dynamic "column" {
    for_each = each.value.column
    content {
      name = column.value.name
      type = column.value.type

      dynamic "default" {
        for_each = column.value.default != null ? [column.value.default] : []
        content {
          expression = default.value
        }
      }
    }
  }
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/table