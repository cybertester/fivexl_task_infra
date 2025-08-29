variable "domain_name" {
  description = "Domain name for the certificate"
  type        = string
}

variable "root_domain" {
  description = "Root domain name (e.g., pecklo.com)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
