include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.database_grants_on_database}"
}

dependencies {
  paths = [
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.db}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.database_roles}",
   ]
}

inputs = {
  relation = local.ns_vars.database_grants_on_database
}