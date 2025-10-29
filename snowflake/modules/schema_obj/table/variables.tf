variable "relation" {
  type = list(object({
    name = string
    database = string
    schema = string
    column   = list(object({
      name = string
      type = string
      default = optional(any)
    }))
  }))
}
