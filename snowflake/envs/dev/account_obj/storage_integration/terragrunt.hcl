terraform {
  source = "../../../../modules/account_obj/storage_integration"
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

dependency "s3" {
  config_path = "/../../../../../AWS/envs/dev/s3"
  
  mock_outputs = {
    original_s3_url = "s3://aws_s3_bucket.snow_bucket.bucket"
  }
}

inputs = {
  storage_integration = {
    name = local.ns_vars.storage_integrations[0].name
    type = local.ns_vars.storage_integrations[0].type
    storage_provider = local.ns_vars.storage_integrations[0].storage_provider
    enabled = local.ns_vars.storage_integrations[0].enabled
    storage_allowed_locations = [dependency.s3.outputs.original_s3_url]
  }
}