resource "aws_lb_listener" "ecs" {

  load_balancer_arn = var.ecs_alb_arn
  port              = var.port_https
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.ccs_intranet.arn
  tags              = var.tags

  default_action {
    target_group_arn = aws_lb_target_group.ccs_intranet.arn
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "redirect_to_www" {
  count = var.environment == "prod" ? 1 : 0

  listener_arn = aws_lb_listener.ecs.arn

  action {
    type = "redirect"

    redirect {
      host        = var.fqdn_application
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = [replace(var.fqdn_application, "www.", "")]
    }
  }

  tags = { Name : "Redirect to www" }
}

resource "aws_lb_listener" "ecs_http" {

  load_balancer_arn = var.ecs_alb_arn
  port              = var.port_http
  protocol          = "HTTP"
  tags              = var.tags

  default_action {
    redirect {
      status_code = "HTTP_301"
      protocol    = "HTTPS"
      port        = "443"
    }
    type = "redirect"
  }
}

resource "aws_lb_target_group" "ccs_intranet" {
  deregistration_delay = 30
  name_prefix          = "${substr(var.environment, 0, 4)}-a"
  port                 = local.app_listening_port
  protocol             = "HTTP"
  tags                 = merge(var.tags, { Name : "${var.environment}-${local.app_service_name}" })
  target_type          = "ip"
  vpc_id               = var.vpc_id

  health_check {
    enabled           = true
    interval          = 120
    timeout           = 60
    healthy_threshold = 10
    path              = "/"
    port              = local.app_listening_port
    protocol          = "HTTP"
    matcher           = "200"
  }

  lifecycle {
    create_before_destroy = false
  }

}
