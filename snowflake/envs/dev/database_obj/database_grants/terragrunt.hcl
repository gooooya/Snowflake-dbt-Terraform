include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.database_grants}"
}

dependencies {
  paths = [
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.database_roles}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
   ]
}

inputs = {
  relation = flatten([
    for r in local.ns_vars.account_roles : [
      for dr in r.grants_database_roles : [
        for role_name in dr.names : {
          database_role_name = "${dr.database}.${role_name}"
          account_role_name  = r.name
        }
      ]
    ]
  ])
  grants =local.ns_vars.database_grunts
}
