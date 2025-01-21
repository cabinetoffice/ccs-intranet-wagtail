data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_organizations_organization" "ccs_intranet" {}

data "aws_iam_policy_document" "build_container_ecr" {
  statement {
    sid = "ECRRead"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
    ]
  }

  statement {
    sid    = "ECRPull"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "StringLike"
      variable = "aws:PrincipalOrgID"
      # This is our organization-wide identifier which can be found after
      # log-in to AWS: <https://console.aws.amazon.com/organizations/home>
      values = [data.aws_organizations_organization.ccs_intranet.id]
    }
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
    ]
  }

  statement {
    sid    = "ECRWrite"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
    ]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }

  statement {
    sid    = "ECRCodeBuild"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type        = "Service"
    }
  }
}
