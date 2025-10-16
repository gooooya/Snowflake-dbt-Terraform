variable "databases" {
  type = list(object({
    name = string
  }))
}
