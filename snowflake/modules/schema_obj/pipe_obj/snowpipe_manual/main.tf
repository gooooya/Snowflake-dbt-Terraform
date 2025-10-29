resource "snowflake_pipe" "pipe" {
  for_each = { for r in var.relation : r.name => r }

  name = each.value.name
  database = each.value.to_database
  schema = each.value.to_schema
  comment = each.value.comment
  auto_ingest = each.value.auto_ingest
  copy_statement = templatefile("${path.module}/sql/${each.value.sql_file_name}", {
    from_database = each.value.from_database
    from_schema = each.value.from_schema
    stage_name = each.value.stage_name
    stage_sub_dir = each.value.stage_sub_dir != "" ? "/${each.value.stage_sub_dir}" : ""
    to_database = each.value.to_database
    to_schema = each.value.to_schema
    target_table = each.value.target_table
    target_format_name = each.value.target_format_name
  })
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/pipe