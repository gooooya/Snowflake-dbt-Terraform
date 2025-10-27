include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.rsa_user}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.db}", 
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.schema}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.warehouses}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.database_roles}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.database_grants_in_schema}",
  ]
}

inputs = {
  users = [
    for u in local.ns_vars.rsa_user : {
      name = u.name
      login_name = u.login_name
      rsa_public_key = file("${local.parent.root_folder}/${u.rsa_public_key}")
      default_role = u.default_role
      default_warehouse = u.default_warehouse
      default_namespace = u.default_namespace
    }
  ]
}
