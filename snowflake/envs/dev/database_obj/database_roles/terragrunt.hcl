include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.database_roles}"
}

dependencies {
  paths = [
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.db}",
   ]
}

inputs = {
  roles = local.ns_vars.database_grants
}
