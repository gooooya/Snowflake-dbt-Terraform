locals {
  root_folder = dirname(find_in_parent_folders("folders.yaml"))
  relative_path_from_route = yamldecode(file(find_in_parent_folders("folders.yaml")))
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "snowflake" {
  account_name  = "${get_env("SNOWFLAKE_ACCOUNT", "")}"  
  organization_name  = "${get_env("SNOWFLAKE_ORGANIZATION_NAME", "")}"
  user = "${get_env("SNOWFLAKE_USER", "")}"
  password = "${get_env("SNOWFLAKE_PASSWORD", "")}"
  role     = "${get_env("SNOWFLAKE_ROLE", "")}"
 }

EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_providers {
    snowflake = {
      source = "snowflakedb/snowflake"
      version = "2.8.0"
    }
  }
}
EOF
}