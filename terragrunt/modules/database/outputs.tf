output "cache_redis_address" {
  value = aws_elasticache_cluster.ccs_intranet.cache_nodes.*.address[0]
}

output "cache_redis_port" {
  value = aws_elasticache_cluster.ccs_intranet.cache_nodes.*.port[0]
}

output "db_identifier" {
  value = aws_db_instance.ccs_intranet.identifier
}

output "db_kms_arn" {
  value = aws_kms_key.rds.arn
}

output "db_name" {
  value = aws_db_instance.ccs_intranet.db_name
}

output "db_postgres_address" {
  value = aws_db_instance.ccs_intranet.address
}

output "db_postgres_port" {
  value = aws_db_instance.ccs_intranet.port
}
