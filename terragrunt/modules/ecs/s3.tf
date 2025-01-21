module "s3_bucket" {
  source = "../s3-bucket"

  allowed_ip_ranges = var.allowed_ip_ranges
  bucket_name       = local.s3_upload_name
  environment       = var.environment
  write_roles       = [var.role_ecs_task_arn]

  tags = var.tags
}
