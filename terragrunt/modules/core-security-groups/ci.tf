resource "aws_security_group" "ci_build" {
  description = "Security group to be attached to the ci-build codebuild jobs"
  name        = "${var.environment}-codebuild-build"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-codebuild-build"
    }
  )
}
