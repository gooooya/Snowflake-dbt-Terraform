variable "relation" {
  type = list(object({
    on_database = string
    database_role_name = string
    privileges = list(string)
  }))
}