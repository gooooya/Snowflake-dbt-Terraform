resource "snowflake_pipe" "pipe" {
  for_each = { for r in var.relation : r.name => r }

  name = each.value.name
  database = each.value.database
  schema = each.value.schema
  comment = each.value.comment
  auto_ingest = each.value.auto_ingest
  copy_statement = templatefile(each.value.sql_file_name, {
    database = each.value.database
    schema = each.value.schema
    target_table = each.value.target_table
    stage_name = each.value.stage_name
    target_format = each.value.target_format
  })
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/pipe