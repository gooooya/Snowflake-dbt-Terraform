variable "relation" {
  type = list(object({
    database_role_name = string
    on_database = string
    on_schema = string
    privileges = list(string)
  }))
}