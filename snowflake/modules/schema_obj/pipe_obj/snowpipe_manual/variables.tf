variable "relation" {
  type = list(object({
    name = string
    database = string
    schema = string
    comment = string
    auto_ingest = bool
    stage_name = string
    target_table = string
    sql_file_name = string
    target_format = string
  }))
}
