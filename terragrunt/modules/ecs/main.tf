resource "aws_ecs_cluster" "ccs_intranet" {
  name = local.cluster_name

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.ccs_intranet.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.ccs_intranet.name
      }
    }
  }

  tags = merge(
    var.tags,
    {
      Name   = local.cluster_name
      Domain = var.fqdn_application
    }
  )
}
