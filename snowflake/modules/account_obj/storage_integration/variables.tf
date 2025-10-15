variable "storage_integration" {
  type = object({
    name = string
    type = string
    storage_provider = string
    enabled = bool
    storage_allowed_locations  = list(string)
  })
}