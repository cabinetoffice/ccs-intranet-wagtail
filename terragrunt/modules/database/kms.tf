resource "aws_kms_alias" "rds" {
  name          = "alias/${var.environment}-rds-main-password"
  target_key_id = aws_kms_key.rds.id
}
resource "aws_kms_key" "rds" {
  description = "RDS Managed main password for ${var.environment}"
  tags        = var.tags
}
