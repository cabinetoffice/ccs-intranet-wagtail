import {
  to = aws_route53_zone.public_hosted_zone
  id = var.hosted_zone_public_id
}

resource "aws_route53_zone" "public_hosted_zone" {

  name = var.hosted_zone_public_name
  tags = merge(var.tags, { environment : "all", state_location : "all" })

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "ecs_alb" {
  zone_id = aws_route53_zone.public_hosted_zone.id
  name    = local.sub_domain_name
  type    = "CNAME"
  ttl     = 60

  records = [aws_lb.ecs.dns_name]
}

resource "aws_route53_record" "ecs_alb_prod_alias" {
  count   = local.sub_domain_name == "www" ? 1 : 0
  zone_id = aws_route53_zone.public_hosted_zone.id
  type    = "A"

  alias {
    evaluate_target_health = true
    name                   = aws_lb.ecs.dns_name
    zone_id                = aws_lb.ecs.zone_id
  }

  name = "ccsintranet.civilservice.gov.uk"
}
