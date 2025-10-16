include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.iam_role}"
}

dependency "s3_integrations" {
  config_path = "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.storage_integration}"
  mock_outputs = {
    storage_aws_iam_user_arn = "123456789012"
    storage_aws_external_id = "123456789012"
  }
}

dependency "s3" {
  config_path = "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowbucket}"
  
  mock_outputs = {
    bucket_arn = "arn:aws:s3:::dummy-bucket"
  }
}

inputs = {
  role_name = local.ns_vars.IAM.role_name
  snowflake_aws_account_arn = dependency.s3_integrations.outputs.storage_aws_iam_user_arn
  snowflake_external_id = dependency.s3_integrations.outputs.storage_aws_external_id
  bucket_arn = dependency.s3.outputs.bucket_arn
}


  