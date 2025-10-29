variable "roles" {
  type = list(object({
    database_name = string
    database_role_name = string
  }))
}
