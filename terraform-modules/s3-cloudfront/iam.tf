module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "6.2.1"

  name = "${var.environment}-website-deploy"

  create_access_key = true

  tags = var.tags
}

resource "aws_iam_user_policy" "deploy_policy" {
  name = "${var.environment}-website-deploy-policy"
  user = module.iam_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          module.s3_bucket.s3_bucket_arn,
          "${module.s3_bucket.s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation"
        ]
        Resource = module.cloudfront.cloudfront_distribution_arn
      }
    ]
  })
}

