variable "grants" {
  type = list(object({
    role_name = string
    user_name = string
  }))
}