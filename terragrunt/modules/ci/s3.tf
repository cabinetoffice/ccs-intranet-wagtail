module "s3_bucket" {
  source      = "../s3-bucket"
  bucket_name = "code-pipeline-${var.environment}-${data.aws_caller_identity.current.account_id}"
  environment = var.environment
  write_roles = [var.ci_build_role_arn, var.ci_pipeline_role_arn]

  tags = var.tags
}
