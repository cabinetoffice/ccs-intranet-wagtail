data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "ci_codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "ci_build_generic" {
  statement {
    sid = "AllowCloudWatchLogAccess"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*:log-stream:*",
    ]
  }

  statement {
    sid = "AllowEC2VPCAccess"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs",
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:UpdateAutoScalingGroup"
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowEC2NetworkInterfacePermissions"
    actions = [
      "ec2:CreateNetworkInterfacePermission"
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*"
    ]
    effect = "Allow"
    condition {
      test     = "StringEquals"
      variable = "ec2:AuthorizedService"

      values = ["codebuild.amazonaws.com"]
    }
  }

  statement {
    sid = "AllowECRAccess"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    sid = "AllowRetentiveGithubToken"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/secrets/github/ccs_intranet_wagtail_token"]
    effect    = "Allow"
  }
}

data "aws_iam_policy_document" "ci_pipeline_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}


data "aws_iam_policy_document" "ci_pipline_generic" {
  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_task_exec" {
  statement {
    effect = "Allow"

    actions = [
      "secretsmanager:Describe*",
      "secretsmanager:Get*",
      "secretsmanager:List*",
    ]
    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:rds!db*",
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.environment}-app-credential*",
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:${var.environment}-govuk-notify-credentials*"
    ]
  }
}
