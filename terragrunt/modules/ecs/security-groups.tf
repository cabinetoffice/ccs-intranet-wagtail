resource "aws_security_group_rule" "ecs_service_to_public_https" {
  description       = "Public access from ${local.name_prefix} service"
  from_port         = var.port_https
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.ecs_service_base_sg_id
  to_port           = var.port_https
  type              = "egress"
}

resource "aws_security_group_rule" "public_access_to_alb_https" {
  description       = "Public access to ${local.name_prefix} service via ALB ${var.port_https}"
  from_port         = var.port_https
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.ecs_alb_sg_id
  to_port           = var.port_https
  type              = "ingress"
}

resource "aws_security_group_rule" "public_access_to_alb_http" {
  description       = "Public access to ${local.name_prefix} service via ALB ${var.port_http}"
  from_port         = var.port_http
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = var.ecs_alb_sg_id
  to_port           = var.port_http
  type              = "ingress"
}

resource "aws_security_group_rule" "ecs_service_to_vpce_ecr_api" {
  description              = "To ECR API VPCE"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.vpce_ecr_api_sg_id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "vpce_ecr_api_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.vpce_ecr_api_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "ecs_service_to_vpce_ecr_dkr" {
  description              = "To ECR Docker VPCE"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.vpce_ecr_dkr_sg_id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "vpce_ecr_dkr_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.vpce_ecr_dkr_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "ecs_service_to_vpce_logs" {
  description              = "To Logs VPCE"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.vpce_logs_sg_id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "vpce_logs_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.vpce_logs_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = 443
  type                     = "ingress"
}


resource "aws_security_group_rule" "ecs_service_to_vpce_s3" {
  description       = "To S3 VPCE"
  from_port         = 443
  protocol          = "TCP"
  security_group_id = var.ecs_service_base_sg_id
  prefix_list_ids   = [var.vpce_s3_prefix_list_id]
  to_port           = 443
  type              = "egress"
}


resource "aws_security_group_rule" "ecs_service_to_vpce_secretsmanager" {
  description              = "To Logs VPCE"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.vpce_secretsmanager_sg_id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "vpce_secretsmanager_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = 443
  protocol                 = "TCP"
  security_group_id        = var.vpce_secretsmanager_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "postgres_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = var.db_postgres_port
  protocol                 = "TCP"
  security_group_id        = var.db_postgres_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = var.db_postgres_port
  type                     = "ingress"
}


resource "aws_security_group_rule" "ecs_service_to_postregs" {
  description              = "To RDS"
  from_port                = var.db_postgres_port
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.db_postgres_sg_id
  to_port                  = var.db_postgres_port
  type                     = "egress"
}

resource "aws_security_group_rule" "redis_from_ecs_service" {
  description              = "From ECS Service"
  from_port                = var.cache_redis_port
  protocol                 = "TCP"
  security_group_id        = var.cache_redis_sg_id
  source_security_group_id = var.ecs_service_base_sg_id
  to_port                  = var.cache_redis_port
  type                     = "ingress"
}


resource "aws_security_group_rule" "ecs_service_to_redis" {
  description              = "To Redis"
  from_port                = var.cache_redis_port
  protocol                 = "TCP"
  security_group_id        = var.ecs_service_base_sg_id
  source_security_group_id = var.cache_redis_sg_id
  to_port                  = var.cache_redis_port
  type                     = "egress"
}
