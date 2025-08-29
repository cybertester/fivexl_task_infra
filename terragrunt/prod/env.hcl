locals {
  domain_name         = "pecklo.com"
  project_name        = "azhitov-fivexl-task"
  aws_region          = "us-east-1"
  environment         = "prod"
  subdomain           = local.domain_name
  remote_state_bucket = "${local.project_name}-${local.environment}-terraform-states"
  tags = {
    Project     = local.project_name
    Environment = local.environment
  }
}
