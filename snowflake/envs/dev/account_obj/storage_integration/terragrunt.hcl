include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.S3_storage_integration}"
}

dependency "s3" {
  config_path = "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowbucket}"

  mock_outputs = {
    original_s3_url = "S3://XXXXX"
  }
}

inputs = {
  storage_integration = {
    name = local.ns_vars.storage_integration.name
    type = local.ns_vars.storage_integration.type
    storage_provider = local.ns_vars.storage_integration.storage_provider
    enabled = local.ns_vars.storage_integration.enabled
    storage_allowed_locations = [dependency.s3.outputs.original_s3_url]
    role_name = local.ns_vars.IAM.role_name
  }
}

# storage_aws_role_arn参考。バージョンによって使用できない可能性あり。
# https://stackoverflow.com/questions/68311357/how-to-create-a-snowflake-storage-integration-with-aws-s3-with-terraform?utm_source=chatgpt.com