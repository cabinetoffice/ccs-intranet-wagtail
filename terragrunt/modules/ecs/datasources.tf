data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_kms_alias" "rds" {
  name = "alias/${var.environment}-rds-main-password"
}

data "aws_secretsmanager_secret" "db_secret" {
  arn = data.aws_db_instance.ccs_intranet.master_user_secret[0].secret_arn
}

data "aws_secretsmanager_secret" "govuk_notify_credentials" {
  name = "${var.environment}-govuk-notify-credentials"
}

data "aws_db_instance" "ccs_intranet" {
  db_instance_identifier = var.db_identifier
}

data "aws_secretsmanager_secret_version" "db_secret" {
  secret_id = data.aws_secretsmanager_secret.db_secret.id
}

data "aws_iam_policy_document" "ecs_task_exec" {
  statement {
    sid    = "AllowAccessToRDSKMS"
    effect = "Allow"

    actions = [
      "kms:Decrypt"
    ]
    resources = [
      data.aws_kms_alias.rds.target_key_arn
    ]
  }
}

data "aws_iam_policy_document" "deployer_step_function" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "cloudwatch_event_invoke_deployer_step_function" {
  statement {
    actions   = ["states:StartExecution"]
    resources = [aws_sfn_state_machine.ecs_force_deploy.arn]
  }
}
