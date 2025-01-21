resource "aws_codebuild_project" "build_application" {
  name          = "${var.environment}-build-application"
  description   = "Build application from the ${local.build_branch} branch"
  service_role  = var.ci_build_role_arn
  build_timeout = 5

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image_pull_credentials_type = "CODEBUILD"
    image                       = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com/build-container:0.0.1"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = true
    environment_variable {
      name  = "AWS_REGION"
      value = data.aws_region.current.name
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = data.aws_caller_identity.current.account_id
    }
    environment_variable {
      name  = "TG_SUB_ENVIRONMENT"
      value = var.environment
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "./terragrunt/buildspecs/build-application.yml"
  }

  vpc_config {
    vpc_id             = var.vpc_id
    security_group_ids = [var.ci_build_sg_id]
    subnets            = var.private_subnet_ids
  }

  cache {
    type = "NO_CACHE"
  }

  tags = var.tags
}
