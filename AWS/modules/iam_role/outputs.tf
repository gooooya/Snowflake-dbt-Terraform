output "iam_role_arn" {
  value = aws_iam_role.snowflake_role.arn
}

output "role_name" {
  value = aws_iam_role.snowflake_role.name
}
