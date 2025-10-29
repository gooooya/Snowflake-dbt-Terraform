include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
}

terraform {
  source =  "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.s3_bucket}"
}

inputs = {
  bucket_name = local.ns_vars.S3.bucket_name
  environment = local.ns_vars.S3.environment
  s3_objects = [
    for obj in local.ns_vars.S3.objects : {
      bucket_name = local.ns_vars.S3.bucket_name
      key = obj.key
      source =  lookup(obj, "source", null) != null ? "${local.parent.root_folder}/${obj.source}" : null 
    }
  ]
}