include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.account_grants}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
      "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.rsa_user}",
      ]
}
# TOOD:↑user統合後削除

inputs = {
  grants = local.ns_vars.grants_user_to_account
}
