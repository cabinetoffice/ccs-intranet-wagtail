resource "aws_elasticache_cluster" "ccs_intranet" {
  apply_immediately    = true
  cluster_id           = "${local.name_prefix}-cache"
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379
  security_group_ids   = [var.cache_redis_sg_id]
  subnet_group_name    = aws_elasticache_subnet_group.ccs_intranet.name

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-cache"
    }
  )
}

resource "aws_elasticache_subnet_group" "ccs_intranet" {
  name       = "${local.name_prefix}-elasticache-private-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-elasticache-private-subnet-group"
    }
  )
}
