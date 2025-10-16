variable "warehouses" {
  type = list(object({
  name = string
  warehouse_size = string
  auto_suspend = number
  auto_resume = bool
  initially_suspended = bool
  }))
}
