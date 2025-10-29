resource "aws_s3_bucket" "snow_bucket" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    Name = var.bucket_name
    Environment = var.environment
  }
}

# TODO:これoptionalであれば格納にする。predでエラーはいてる。
resource "aws_s3_object" "object" {
  for_each = { for s in var.s3_objects : "${s.bucket_name}--${s.key}" => s }
  
  bucket = each.value.bucket_name
  key = each.value.key
  source = each.value.source != null ? each.value.source : null
}
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object


resource "aws_s3_bucket_public_access_block" "snow_bucket" {
  bucket = aws_s3_bucket.snow_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}