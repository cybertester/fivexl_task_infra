variable "environment" {
  description = "Environment name"
  type        = string
}

variable "domain_name" {
  description = "Domain name for the website"
  type        = string
}

variable "custom_domain" {
  description = "Custom domain for CloudFront (e.g., dev.pecklo.com)"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ACM certificate ARN for custom domain"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    "Project" = "FiveXl_task"
  }
}
