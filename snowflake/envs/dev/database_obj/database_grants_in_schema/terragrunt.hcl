include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.database_grants_in_schema}"
}

dependencies {
  paths = [
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.database_roles}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.user}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_stage}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_pipe}",
   ]
}

inputs = {
  grants = flatten([
    for g in local.ns_vars.database_grants_in_schema : [
      for obj_type, priv_list in g.object_privileges : {
        database_role_name = "${g.database_name}.${g.database_role_name}"
        database_name = g.database_name
        in_schema = "${g.database_name}.${g.in_schema}"
        object_type_plural = obj_type
        privileges = priv_list
      }
    ]
  ])
}