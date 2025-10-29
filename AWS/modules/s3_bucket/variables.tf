variable "bucket_name" { type = string }
variable "environment" { type = string }

variable "s3_objects" {
  type = list(object({
    bucket_name = string
    key = string
    source = optional(string, null)
  }))
}