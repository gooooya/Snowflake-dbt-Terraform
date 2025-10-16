output "storage_aws_iam_user_arn" {
  value = snowflake_storage_integration.this.storage_aws_iam_user_arn
}

output "storage_aws_external_id" {
  value = snowflake_storage_integration.this.describe_output[0].storage_aws_external_id[0].value
}