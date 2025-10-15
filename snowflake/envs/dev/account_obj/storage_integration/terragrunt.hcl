include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}


terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.storage_integration}"
}

dependency "s3" {
  config_path = "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowbucket}"

  mock_outputs = {
    original_s3_url = "s3://aws_s3_bucket.snow_bucket.bucket"
  }
}

inputs = {
  storage_integration = {
    name = local.ns_vars.storage_integrations.name
    type = local.ns_vars.storage_integrations.type
    storage_provider = local.ns_vars.storage_integrations.storage_provider
    enabled = local.ns_vars.storage_integrations.enabled
    storage_allowed_locations = [dependency.s3.outputs.original_s3_url]
  }
}