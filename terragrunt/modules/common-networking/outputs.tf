output "ecr_build_container_name" {
  value = aws_ecr_repository.build_container.name
}

output "ecs_alb_arn" {
  value = aws_lb.ecs.arn
}

output "fqdn_application" {
  value = aws_route53_record.ecs_alb.fqdn
}

output "hosted_zone_public_id" {
  value = aws_route53_zone.public_hosted_zone.id
}

output "vpce_s3_prefix_list_id" {
  value = aws_vpc_endpoint.s3.prefix_list_id
}
