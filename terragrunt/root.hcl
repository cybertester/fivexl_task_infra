terragrunt_version_constraint = ">= 0.86"

locals {
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  tf_providers = {
    aws        = "6.11.0"
  }
  terraform_version = ">= 1.13"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    region                      = local.env_vars.locals.aws_region
    bucket                      = local.env_vars.locals.remote_state_bucket
    key                         = "${path_relative_to_include()}/terraform.tfstate"
    encrypt                     = true
    skip_metadata_api_check     = true
    skip_credentials_validation = true
  }
}

inputs = merge(
  local.env_vars.inputs
)
