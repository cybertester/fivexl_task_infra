output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_arn
}

output "bucket_website_endpoint" {
  description = "Website endpoint of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_website_endpoint
}

output "deploy_access_key_id" {
  description = "Access key ID for deployment user"
  value       = module.iam_user.access_key_id
}

output "deploy_secret_access_key" {
  description = "Secret access key for deployment user"
  value       = module.iam_user.access_key_secret
  sensitive   = true
}

output "cloudfront_distribution_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "ID of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = module.cloudfront.cloudfront_distribution_arn
}