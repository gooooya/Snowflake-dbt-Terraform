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

  grants = flatten([
    for g in local.ns_vars.database_grants : [
      for obj_type, priv_list in g.object_privileges : {
        database_role_name = g.database_role_name
        database_name = g.database_name
        in_schema = g.in_schema
        object_type_plural = obj_type
        privileges = priv_list
      }
    ]
  ])
}