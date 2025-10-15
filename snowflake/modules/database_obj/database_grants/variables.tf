variable "relation" {
  type = list(object({
    database_role_name = string
    account_role_name = string
  }))
}

variable "grants" {
  type = list(object({
    database_name = string
    database_role_name = string
    in_schema = string
    object_type_plural = string
    privileges = list(string)
  }))
}
