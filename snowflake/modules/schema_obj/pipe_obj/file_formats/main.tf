resource "snowflake_file_format" "file_format" {
  
  for_each = { for f in var.file_format : f.name => f }
  name = each.value.name
  database = each.value.database
  schema = each.value.schema
  format_type  = each.value.format_type
}
# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/file_format