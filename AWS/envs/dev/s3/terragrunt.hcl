terraform {
  source = "../../../modules/s3_bucket"
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  env_locals  = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
  root_locals  = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

inputs = {
  bucket_name = "${local.root_locals.prefix}${local.env_locals.env}-8678473"
  environment = local.env_locals.env
}
