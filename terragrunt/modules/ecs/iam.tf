resource "aws_iam_policy" "ecs_task_exec" {
  name   = "${var.environment}-ecs-task-exec-kms"
  policy = data.aws_iam_policy_document.ecs_task_exec.json
  tags   = var.tags
}

resource "aws_iam_policy_attachment" "ecs_task_exec" {
  name       = "${var.environment}-ecs-task-exec-kms-attachment"
  policy_arn = aws_iam_policy.ecs_task_exec.arn
  roles      = [var.role_ecs_task_exec_name]
}


resource "aws_iam_policy" "ecs_service_update_policy" {
  name        = "${var.environment}-ecs-service-update-policy"
  description = "Policy for updating ECS services"
  policy      = data.aws_iam_policy_document.deployer_step_function.json
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_service_update_role_attachment" {
  role       = var.role_ecs_deployer_step_function_name
  policy_arn = aws_iam_policy.ecs_service_update_policy.arn
}

resource "aws_iam_role" "cloudwatch_events_role" {
  name = "${var.environment}-cloudwatch-events-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "events.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_policy" "cloudwatch_event_invoke_deployer_step_function" {
  name        = "${var.environment}-cloudwatch-events-policy"
  description = "Policy for CloudWatch Events to invoke Step Functions"
  policy      = data.aws_iam_policy_document.cloudwatch_event_invoke_deployer_step_function.json
}

resource "aws_iam_policy_attachment" "cloudwatch_event_invoke_deployer_step_function_attachment" {
  name       = "${var.environment}-cloudwatch-events-role-attachment"
  roles      = [aws_iam_role.cloudwatch_events_role.name]
  policy_arn = aws_iam_policy.cloudwatch_event_invoke_deployer_step_function.arn
}
