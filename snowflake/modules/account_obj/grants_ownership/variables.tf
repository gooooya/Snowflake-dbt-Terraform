variable "grants_ownership" {
  type = list(object({
    object_type = string
    object_name = string
    account_role_name = string
  }))
}