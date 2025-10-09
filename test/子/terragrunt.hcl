locals {
  parent = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl")).locals
}

inputs = {
  root = "${local.parent.root_folder}\\${local.parent.relative_path_from_route.terragrunt.db}"
}

terraform {
  source = "./"
}