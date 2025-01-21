data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_codestarconnections_connection" "cabinet_office" {
  name = "CabinetOffice"
}

data "aws_s3_bucket" "tfstate_bucket" {
  bucket = var.tfstate_bucket_name
}

data "aws_dynamodb_table" "tfstate_lock" {
  name = "terraform-locks"
}

data "aws_iam_policy_document" "code_pipeline_bucket" {
  statement {
    sid    = "CodeBuildAccess"
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = [
        var.ci_pipeline_role_arn,
        var.ci_build_role_arn
      ]
    }
    actions = ["s3:*"]
    resources = [
      module.s3_bucket.arn,
      "${module.s3_bucket.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "ci_pipline" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      module.s3_bucket.arn,
      "${module.s3_bucket.arn}/*"
    ]
  }

  statement {
    actions = [
      "codestar-connections:GetConnection",
      "codestar-connections:ListConnections",
      "codestar-connections:UseConnection"
    ]
    effect    = "Allow"
    resources = [data.aws_codestarconnections_connection.cabinet_office.arn]
  }

  statement {
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt"
    ]
    effect    = "Allow"
    resources = [aws_kms_key.pipeline_bucket.arn]
  }

  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]
    effect = "Allow"
    resources = [
      aws_codebuild_project.build_application.arn

    ]
  }
}

data "aws_iam_policy_document" "ci_build" {
  statement {
    actions = [
      "s3:GetBucketAccelerateConfiguration",
      "s3:GetBucketAcl",
      "s3:GetBucketCors",
      "s3:GetBucketOwnershipControls",
      "s3:GetBucketPolicy",
      "s3:GetBucketVersioning",
      "s3:GetBucketWebsite",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    effect = "Allow"
    resources = [
      module.s3_bucket.arn,
      "${module.s3_bucket.arn}/*",
      data.aws_s3_bucket.tfstate_bucket.arn,
      "${data.aws_s3_bucket.tfstate_bucket.arn}/*",
    ]
  }

  statement {
    actions = [
      "s3:GetBucketAccelerateConfiguration",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:List*",
      "dynamodb:PutItem",
    ]
    effect    = "Allow"
    resources = [data.aws_dynamodb_table.tfstate_lock.arn]
  }

  statement {
    actions = [
      "iam:Add*",
      "iam:Attach*",
      "iam:Delete*",
      "iam:Detach*",
      "iam:Get*",
      "iam:List*",
      "iam:Put*",
      "iam:Update*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.environment}-*",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/${var.environment}-*"
    ]
  }

  statement {
    actions = [
      "codebuild:BatchGet*",
      "codebuild:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:codebuild:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:project/${var.environment}-*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "codepipeline:GetPipeline",
      "codepipeline:ListTagsForResource",
    ]
    resources = [
      "arn:aws:codepipeline:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.environment}-*",
    ]
  }

  statement {
    actions = [
      "rds:Describe*",
      "rds:Get*",
      "rds:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*:${var.environment}-*",
    ]
  }

  statement {
    actions = [
      "elasticache:Describe*",
      "elasticache:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:elasticache:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*:${var.environment}-*",
    ]
  }

  statement {
    actions = [
      "rds:Describe*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:rds:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*",
    ]
  }

  statement {
    actions = [
      "wafv2:Get*",
      "wafv2:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/ipset/${var.environment}-*",
      "arn:aws:wafv2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:regional/webacl/${var.environment}-*"
    ]
  }

  statement {
    actions = [
      "ec2:Describe*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:List*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "route53:GetHostedZone",
      "route53:List*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "codebuild:List*"
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "codestar-connections:GetConnection",
      "codestar-connections:ListTagsForResource",
      "codestar-connections:UseConnection",
    ]
    effect    = "Allow"
    resources = [data.aws_codestarconnections_connection.cabinet_office.arn]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListResourceTags",
    ]
    effect    = "Allow"
    resources = [aws_kms_key.pipeline_bucket.arn]
  }

  statement {
    actions = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey",
      "kms:GetKeyPolicy",
      "kms:GetKeyRotationStatus",
      "kms:ListResourceTags",
    ]
    effect    = "Allow"
    resources = [aws_kms_key.pipeline_bucket.arn]
  }

  statement {
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "secretsmanager:Describe*",
      "secretsmanager:Get*"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:secretsmanager:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:secret:rds!db-*"
    ]
  }

  statement {
    actions = [
      "ecr:List*"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:ecr:eu-west-2:767398093036:repository/*"
    ]
  }

  statement {
    actions = [
      "logs:Describe*",
      "logs:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group::log-stream:",
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/ecs/test-*:log-stream:",
    ]
  }

  statement {
    actions = [
      "acm:Describe*",
      "acm:List*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:acm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:certificate/*",
    ]
  }

  statement {
    actions = [
      "ecs:Describe*",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/${var.environment}*",
    ]
  }

  statement {
    actions = [
      "ecs:Describe*",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "organizations:DescribeAccount",
      "organizations:DescribeOrganization",
    ]
    effect    = "Allow"
    resources = ["*"]
  }

  statement {
    actions = [
      "codestar-connections:ListConnections",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:codestar-connections:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*",
    ]
  }
}
