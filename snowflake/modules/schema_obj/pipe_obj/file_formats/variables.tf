variable "file_format" {
  type = list(object({
    name = string
    database = string
    schema = string
    format_type = string
  }))
}
