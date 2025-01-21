resource "aws_ecr_repository" "ccs_intranet" {
  name                 = local.name_prefix
  image_tag_mutability = "MUTABLE"


  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(
    var.tags,
    {
      Name           = local.name_prefix
      environment    = "production to be"
      state_location = "production to be"
    }
  )
}
