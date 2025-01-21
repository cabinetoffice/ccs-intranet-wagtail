resource "aws_iam_role" "ecs_task" {
  name = "${var.environment}-ecs-task"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role" "ecs_task_exec" {
  name = "${var.environment}-ecs-task-exec"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ecs-tasks.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "ecs_task_exec" {
  name   = "${var.environment}-ecs-task-exec"
  policy = data.aws_iam_policy_document.ecs_task_exec.json
  tags   = var.tags
}

resource "aws_iam_policy_attachment" "ecs_task_exec" {
  name       = "${var.environment}-ecs-task-exec-attachment"
  policy_arn = aws_iam_policy.ecs_task_exec.arn
  roles      = [aws_iam_role.ecs_task_exec.name]
}

resource "aws_iam_role_policy_attachment" "ecs_task_exec_generic" {
  role       = aws_iam_role.ecs_task_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_deployer_step_function" {
  name = "${var.environment}-deployer-step-function"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "states.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}
