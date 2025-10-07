terragrunt参考
https://qiita.com/ssc-ksaitou/items/c3eedd46a5eb04d731cc

locals {
  aws_region       = "us-east-1"
  bucket_name_dev  = "my-bucket-dev-20251003"
  bucket_name_prod = "my-bucket-prod-20251003"
  env_name = basename(get_terragrunt_dir()) # devディレクトリなら "dev"
  # 下みたいな使い方もできるらしいけどいまいち有用性を理解できていない。
  # env_map = {
  #   dev  = local.bucket_name_dev
  #   prod = local.bucket_name_prod
  # }
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

# ほかにリソースを使う場合、以下のようにするのがいいっぽい(未確認)
terragrunt apply-all

envs/
└─ dev/
   ├─ s3_bucket/
   │   └─ terragrunt.hcl  ← S3専用
   └─ lambda/
       └─ terragrunt.hcl  ← Lambda専用