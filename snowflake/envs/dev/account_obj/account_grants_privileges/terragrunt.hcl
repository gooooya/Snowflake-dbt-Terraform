include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.account_grants_privileges}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.account_roles}",
      "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.warehouses}",
      ]
}
# TODO:object_typeが可変のため、dependencies固定できない。対象のobject_type列挙しなきゃダメな作りになってる気がする。

inputs = {
  grants = local.ns_vars.account_grants_privileges
}
