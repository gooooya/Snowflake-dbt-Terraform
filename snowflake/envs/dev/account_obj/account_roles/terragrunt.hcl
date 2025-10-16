include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.account_role}"
}

inputs = {
  roles = [
    for a in local.ns_vars.account_roles:{
      name = a.name
      comment = a.comment
    }
  ]
}
