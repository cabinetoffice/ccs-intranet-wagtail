resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.build_container.name

  policy = data.aws_iam_policy_document.build_container_ecr.json
}

import {
  to = aws_ecr_repository.heartbeat
  id = "heartbeat"
}

resource "aws_ecr_repository" "heartbeat" {
  name                 = "heartbeat"
  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.tags,
    {
      Name           = "heartbeat"
      environment    = "production to be"
      state_location = "production to be"
    }
  )
}

import {
  to = aws_ecr_repository.build_container
  id = "build-container"
}

resource "aws_ecr_repository" "build_container" {
  name                 = "build-container"
  image_tag_mutability = "IMMUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.tags,
    {
      Name           = "build-container"
      environment    = "production to be"
      state_location = "production to be"
    }
  )
}
