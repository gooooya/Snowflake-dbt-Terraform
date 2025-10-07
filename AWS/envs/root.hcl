locals {
  aws_region = "us-east-1"
  prefix = "my-bucket-"
}

# AWSプロバイダ設定を共通化
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}