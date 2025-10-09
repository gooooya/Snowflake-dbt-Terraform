locals {
  root_folder = dirname(find_in_parent_folders("folders.yaml"))
  relative_path_from_route = yamldecode(file(find_in_parent_folders("folders.yaml")))
}

terraform {
  source = "./"
}

inputs = {
  base_path = "${local.root_folder}\\${local.relative_path_from_route.terragrunt.db}"
}
