# TODO:ここキモイので置き場所検討する。rootに全部まとめておくしかないか？
data "aws_caller_identity" "current" {}
provider "aws" {
  region = "us-east-1"
}

resource "snowflake_storage_integration" "this" {
  name = var.storage_integration.name
  type = var.storage_integration.type
  enabled = var.storage_integration.enabled
  storage_allowed_locations = var.storage_integration.storage_allowed_locations
  
  storage_provider = var.storage_integration.storage_provider
  storage_aws_role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.storage_integration.role_name}"
}

# https://registry.terraform.io/providers/snowflakedb/snowflake/latest/docs/resources/storage_integration
# storage_aws_role_arnを設定する都合上、これS3専用かも。