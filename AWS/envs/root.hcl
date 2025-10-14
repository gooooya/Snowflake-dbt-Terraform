locals {
  aws_region = "us-east-1"
  prefix = "my-bucket-"
  root_folder = dirname(find_in_parent_folders("folders.yaml"))
  relative_path_from_route = yamldecode(file(find_in_parent_folders("folders.yaml")))
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