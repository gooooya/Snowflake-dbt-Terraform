include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  parent = read_terragrunt_config(find_in_parent_folders("root.hcl")).locals
  ns_vars = yamldecode(file(find_in_parent_folders("namespace_vars.yaml")))
}

terraform {
  source = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.snowpipe_manual}"
}

dependencies {
  paths = ["${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.db}", 
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.schema}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_stage}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_table}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.test_format}",
    "${local.parent.root_folder}/${local.parent.relative_path_from_route.terragrunt.dev.snowflake_role_dev}",
  ]
}

inputs = {
  relation = [
    for p in local.ns_vars.pipes : {
      name = p.name
      database = p.database
      schema = p.schema
      comment = p.comment
      auto_ingest = p.auto_ingest
      stage_name = p.stage_name
      target_table = p.target_table
      target_format_name = p.target_format_name
      sql_file_name = "${local.parent.root_folder}/${local.parent.relative_path_from_route.module.snowpipe_manual}/sql/${p.sql_file_name}"
    }
  ]
}