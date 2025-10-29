include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.snowpipe_manual}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.db}", 
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.schema}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.stage}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.table}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.file_formats}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowflake_role_dev}",
  ]
}

inputs = {
  relation = local.ns_vars.pipes
}