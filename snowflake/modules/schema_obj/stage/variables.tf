variable "stage" {
  type = object({
    name = string
    database = string
    schema = string
    storage_integration  = string
    encryption = string
    s3_url = string
  })
}
