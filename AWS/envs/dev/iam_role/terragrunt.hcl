# AWS/envs/dev/iam_role/terragrunt.hcl
terraform {
  source = "../../../modules/iam_role"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "s3_integrations" {
  config_path = "../../../../snowflake/envs/dev/account_obj/storage_integration"
  
  mock_outputs = {
    storage_aws_iam_user_arn = "123456789012"
    storage_aws_external_id = "123456789012"
  }
}

dependency "s3" {
  config_path = "../s3"
  
  mock_outputs = {
    bucket_arn = "arn:aws:s3:::dummy-bucket"
  }
}

inputs = {
  role_name = "snowflake_role_dev"
  snowflake_aws_account_arn = dependency.s3_integrations.outputs.storage_aws_iam_user_arn
  snowflake_external_id = dependency.s3_integrations.outputs.storage_aws_external_id
  bucket_arn = dependency.s3.outputs.bucket_arn
}
