variable "relation" {
  type = list(object({
    database_name = string
    schema_name = string
  }))
}
