resource "aws_s3_bucket" "snow_bucket" {
  bucket = var.bucket_name
  force_destroy = true
  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "snow_bucket" {
  bucket = aws_s3_bucket.snow_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}