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
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.user}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.stage}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowpipe}",
   ]
}

inputs = {
  relation = flatten([
    for ar in local.ns_vars.account_roles : [
      for grant in ar.grants_database_roles : [
        for db_role in grant.names : {
          database_role_name = "${grant.database}.${db_role}"
          parent_role_name  = ar.name
        }
      ]
    ]
  ])
}