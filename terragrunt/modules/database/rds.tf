resource "aws_db_subnet_group" "ccs_intranet" {
  name       = "${local.name_prefix}-db-private-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge(
    var.tags,
    {
      Name = "${local.name_prefix}-db-private-subnet-group"
    }
  )
}

resource "aws_db_parameter_group" "ccs_intranet" {
  name   = "${local.name_prefix}-${floor(var.version_postgres_engine)}"
  family = "postgres${floor(var.version_postgres_engine)}"

  parameter {
    apply_method = "pending-reboot"
    name         = "max_connections"
    value        = "100"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "ccs_intranet" {
  allocated_storage                   = 20
  apply_immediately                   = true
  auto_minor_version_upgrade          = true
  backup_retention_period             = var.environment == "prod" ? 14 : 0
  character_set_name                  = ""
  db_name                             = replace(local.name_prefix, "-", "_")
  db_subnet_group_name                = aws_db_subnet_group.ccs_intranet.name
  engine                              = "postgres"
  engine_version                      = var.version_postgres_engine
  iam_database_authentication_enabled = true
  identifier                          = local.name_prefix
  instance_class                      = var.postgres_instance_type
  manage_master_user_password         = true
  master_user_secret_kms_key_id       = aws_kms_key.rds.id
  multi_az                            = var.environment == "prod"
  parameter_group_name                = aws_db_parameter_group.ccs_intranet.name
  skip_final_snapshot                 = true
  storage_encrypted                   = true
  username                            = "${replace(local.name_prefix, "-", "_")}_main_db_user"
  vpc_security_group_ids              = [var.db_postgres_sg_id]

  tags = merge(
    var.tags,
    {
      Name = replace(local.name_prefix, "-", "_")
    }
  )
}
