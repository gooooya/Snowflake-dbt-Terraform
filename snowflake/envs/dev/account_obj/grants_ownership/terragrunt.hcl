include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.grants_ownership}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_pipe}", 
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
  ]
}

inputs = {
  grants_ownership = local.ns_vars.grants_ownership
}
