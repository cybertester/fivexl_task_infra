include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
}

terraform {
  source = "../../../terraform-modules//s3-cloudfront"
}

dependency "acm_certificate" {
  config_path = "../acm-certificate"
}

inputs = {
  aws_region      = include.env.locals.aws_region
  environment     = include.env.locals.environment
  domain_name     = include.env.locals.domain_name
  custom_domain   = include.env.locals.subdomain
  certificate_arn = dependency.acm_certificate.outputs.certificate_arn
  tags            = include.env.locals.tags
}

generate "providers_versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = "${include.root.locals.terraform_version}"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "${include.root.locals.tf_providers.aws}"
    }
  }
}
EOF
}