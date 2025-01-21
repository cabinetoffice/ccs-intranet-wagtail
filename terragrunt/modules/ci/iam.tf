resource "aws_iam_role_policy" "ci_build" {
  name   = "${var.environment}-ci-build-policy"
  policy = data.aws_iam_policy_document.ci_build.json
  role   = var.ci_build_role_name
}

resource "aws_iam_role_policy" "ci_pipline" {
  name   = "${var.environment}-ci-pipeline-policy"
  policy = data.aws_iam_policy_document.ci_pipline.json
  role   = var.ci_pipeline_role_name
}
