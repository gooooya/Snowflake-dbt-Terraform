output "bucket_name" { value = aws_s3_bucket.snow_bucket.bucket }
output "bucket_arn"  { value = aws_s3_bucket.snow_bucket.arn }
output "original_s3_url" {
  value = "s3://${aws_s3_bucket.snow_bucket.bucket}/"
}