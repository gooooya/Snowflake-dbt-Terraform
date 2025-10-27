variable "grants" {
  type = list(object({
    account_role_name = string
    privileges = list(string)
    object_type = string
    object_name = string
  }))
}