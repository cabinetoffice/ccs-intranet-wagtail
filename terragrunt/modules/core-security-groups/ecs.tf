resource "aws_security_group" "ecs_service_base" {
  description = "Security group to be attached to all services"
  name        = "${var.environment}-ecs-service-base"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-ecs-service-base"
    }
  )
}
