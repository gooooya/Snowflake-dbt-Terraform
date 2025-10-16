include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.stage}"
}

dependencies {
  paths = [
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.schema}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.storage_integration}",
  ]
}

dependency "s3" {
  config_path = "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowbucket}"

  mock_outputs = {
    original_s3_url = "S3://XXXXX"
  }
}

inputs = {
  stage = {
    name = local.ns_vars.stage.name
    database = local.ns_vars.stage.database
    schema = local.ns_vars.stage.schema
    storage_integration = local.ns_vars.stage.storage_integration
    encryption = local.ns_vars.stage.encryption
    s3_url = dependency.s3.outputs.original_s3_url
  }
}