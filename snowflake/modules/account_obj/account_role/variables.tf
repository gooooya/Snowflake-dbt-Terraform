variable "roles" {
  type = list(object({
    name = string
    comment = string
  }))
}
