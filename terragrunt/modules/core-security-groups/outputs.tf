output "alb_sg_id" {
  value = aws_security_group.alb.id
}

output "cache_redis_sg_id" {
  value = aws_security_group.elasticache_redis.id
}

output "ci_build_sg_id" {
  value = aws_security_group.ci_build.id
}

output "db_postgres_sg_id" {
  value = aws_security_group.db_postgres.id
}

output "ecs_service_base_sg_id" {
  value = aws_security_group.ecs_service_base.id
}

output "vpce_ecr_api_sg_id" {
  value = aws_security_group.vpce_ecr_api.id
}

output "vpce_ecr_dkr_sg_id" {
  value = aws_security_group.vpce_ecr_dkr.id
}

output "vpce_logs_sg_id" {
  value = aws_security_group.vpce_logs.id
}

output "vpce_s3_sg_id" {
  value = aws_security_group.vpce_s3.id
}

output "vpce_secretsmanager_sg_id" {
  value = aws_security_group.vpce_secretsmanager.id
}
