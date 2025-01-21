resource "aws_kms_key" "pipeline_bucket" {
  description             = "KMS key to use for the pipeline artefacts"
  deletion_window_in_days = 7
  tags                    = var.tags
}

resource "aws_kms_alias" "pipeline_bucket" {
  name          = "alias/${var.environment}-pipeline-bucket"
  target_key_id = aws_kms_key.pipeline_bucket.id
}
