variable "users" {
  type = list(object({
    name = string
    login_name = string
    password = optional(string, null)
    rsa_public_key = string
    default_role = string
    default_warehouse = string
    default_namespace = string
  }))
  sensitive = true
}

# 絶対実務でやったらあかんやつ password = optional(strin, "aaa")