# FiveXL Task Infrastructure

This project manages AWS infrastructure using Terragrunt for different environments.

## Structure

```
terragrunt/
├── root.hcl                    # Root configuration with provider versions
├── dev/
│   ├── env.hcl                 # Dev environment variables
│   ├── acm-certificate/
│   │   └── terragrunt.hcl      # Dev ACM certificate config
│   └── s3-cloudfront/
│       └── terragrunt.hcl      # Dev S3+CloudFront config
└── prod/
    ├── env.hcl                 # Prod environment variables
    ├── acm-certificate/
    │   └── terragrunt.hcl      # Prod ACM certificate config
    └── s3-cloudfront/
        └── terragrunt.hcl      # Prod S3+CloudFront config

terraform-modules/
├── acm-certificate/            # ACM SSL certificate module
└── s3-cloudfront/             # S3 bucket + CloudFront module
```

## Environments

- **Dev**: `dev.pecklo.com` with ACM certificate and S3+CloudFront
- **Prod**: `pecklo.com` with ACM certificate and S3+CloudFront

## Monthly Costs (US East 1)

### Per Environment (less than one GB content, minimal traffic):
- **ACM Certificate**: $0 (free for AWS services)
- **S3 Storage**: ~$0.01 (less than one GB content)
- **CloudFront**: ~$0.50 (minimal traffic)

### Total Estimated Costs:
- **Dev Environment**: ~$0.51/month
- **Prod Environment**: ~$0.51/month
- **Both Environments**: ~$1.02/month

*Costs based on minimal usage. State locking disabled for single-user setup.*

## Usage

### Deploy Infrastructure

```bash
# Dev environment
cd terragrunt/dev/acm-certificate
terragrunt apply

cd ../s3-cloudfront
terragrunt apply

# Prod environment  
cd ../../prod/acm-certificate
terragrunt apply

cd ../s3-cloudfront
terragrunt apply
```
or use `terragrunt apply --all` from `terragrunt/dev` or `terragrunt/prod`.

### Remote State

Terragrunt automatically creates:
- S3 buckets for state storage (`azhitov-fivexl-task-{env}-terraform-states`)
- Enables versioning and encryption

### Certificate Validation

Certificates are created with DNS validation method but require manual validation:
1. Go to AWS Console → Certificate Manager
2. Find the certificate
3. Add the DNS validation records to your DNS provider
4. Wait for validation to complete

## Modules

### ACM Certificate Module
- Creates SSL certificates for custom domains
- Uses DNS validation method

### S3-CloudFront Module  
- S3 bucket for static website hosting
- CloudFront distribution with custom domain
- IAM user for CI/CD deployments

## Configuration

- Provider versions defined in `root.hcl`
- Environment-specific settings in `env.hcl` files
- Terraform state stored in S3 
