variable "users" {
  type = list(object({
    name = string
    login_name = string
    rsa_public_key = string
    default_role = string
    default_warehouse = string
    default_namespace = string
  }))
}