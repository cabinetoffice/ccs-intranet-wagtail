resource "aws_security_group" "db_postgres" {
  description = "Security group to be attached to the Postgres DB"
  name        = "${var.environment}-postgres"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-postgres"
    }
  )
}

resource "aws_security_group" "elasticache_redis" {
  description = "Security group to be attached to the Redis Elasticache"
  name        = "${var.environment}-redis"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-redis"
    }
  )
}
