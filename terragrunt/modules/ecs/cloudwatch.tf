resource "aws_kms_key" "ccs_intranet" {
  description             = "ECS ${local.cluster_name} for Cloudwatch log-group"
  deletion_window_in_days = 7

  tags = merge(
    var.tags,
    {
      Name = local.cluster_name
    }
  )
}

resource "aws_cloudwatch_log_group" "ccs_intranet" {
  name = "/ecs/${local.cluster_name}"

  retention_in_days = var.environment == "prod" ? 0 : 90

  tags = merge(
    var.tags,
    {
      Name = local.cluster_name
    }
  )
}

resource "aws_cloudwatch_event_rule" "ecr_push_event_rule" {
  name        = "ECRPushEvent-${aws_ecr_repository.ccs_intranet.name}"
  description = "CloudWatch Event rule to detect ECR push events to ${aws_ecr_repository.ccs_intranet.name}"

  event_pattern = jsonencode(
    {
      "source" : ["aws.ecr"],
      "detail-type" : ["ECR Image Action"],
      "detail" : {
        "action-type" : ["PUSH"],
        "image-tag" : ["latest"],
        "repository-name" : [aws_ecr_repository.ccs_intranet.name]
        "result" : ["SUCCESS"],
      }
    }
  )

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "step_function_target" {
  rule     = aws_cloudwatch_event_rule.ecr_push_event_rule.name
  arn      = aws_sfn_state_machine.ecs_force_deploy.arn
  role_arn = aws_iam_role.cloudwatch_events_role.arn
}
