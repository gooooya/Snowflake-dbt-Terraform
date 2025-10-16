include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_locals  = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source =  "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.s3_bucket}"
}

inputs = {
  bucket_name = "${local.parent.prefix}${local.env_locals.env}-${basename(get_terragrunt_dir())}-8678473"
  environment = local.env_locals.env
}
