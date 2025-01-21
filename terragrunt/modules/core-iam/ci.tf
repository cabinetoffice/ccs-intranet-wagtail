locals {
  codebuild_iam_name = "${var.environment}-ci-codebuild"
  pipeline_iam_name  = "${var.environment}-ci-pipeline"
}

resource "aws_iam_role" "ci_build" {
  assume_role_policy = data.aws_iam_policy_document.ci_codebuild_assume_role_policy.json
  name               = local.codebuild_iam_name
  tags               = var.tags
}

resource "aws_iam_policy" "ci_build_generic" {
  name   = "${local.codebuild_iam_name}-generic-policy"
  policy = data.aws_iam_policy_document.ci_build_generic.json
  tags   = var.tags
}

resource "aws_iam_policy_attachment" "generic_codebuild_policy" {
  name       = "${local.codebuild_iam_name}-generic-policy-attahment"
  policy_arn = aws_iam_policy.ci_build_generic.arn
  roles      = [aws_iam_role.ci_build.name]
}

resource "aws_iam_role" "ci_pipeline" {
  assume_role_policy = data.aws_iam_policy_document.ci_pipeline_assume_role_policy.json
  name               = local.pipeline_iam_name
  tags               = var.tags
}

resource "aws_iam_policy" "ci_pipeline_generic" {
  name   = "${local.pipeline_iam_name}-generic-policy"
  policy = data.aws_iam_policy_document.ci_build_generic.json
  tags   = var.tags
}


resource "aws_iam_policy_attachment" "generic_pipeline_policy" {
  name       = "${local.pipeline_iam_name}-generic-policy-attachment"
  policy_arn = aws_iam_policy.ci_build_generic.arn
  roles      = [aws_iam_role.ci_build.name]
}
