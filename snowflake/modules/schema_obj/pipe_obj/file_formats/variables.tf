variable "file_format" {
  type = list(object({
    name = string
    database = string
    schema = string
    format_type = string
    skip_header = optional(number, 0)
    field_delimiter = optional(string) 
  }))
}
