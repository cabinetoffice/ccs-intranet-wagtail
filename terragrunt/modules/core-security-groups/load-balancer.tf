resource "aws_security_group" "alb" {
  description = "Security group to be attached to all services"
  name        = "${var.environment}-alb"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-alb"
    }
  )
}
