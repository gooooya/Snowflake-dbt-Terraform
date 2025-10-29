variable "relation" {
  type = list(object({
    name = string
    from_database = string
    from_schema = string
    stage_name = string
    stage_sub_dir = optional(string, "")
    to_database = string
    to_schema = string
    target_table = string
    comment = string
    auto_ingest = bool
    sql_file_name = string
    target_format_name = string
  }))
}
