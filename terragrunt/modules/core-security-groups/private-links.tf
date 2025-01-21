resource "aws_security_group" "vpce_ecr_api" {
  description = "To control traffic to and from ECR API VPC endpoint"
  name        = "${var.environment}-vpce-ecr-api"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpce-ecr-api"
    }
  )
}

resource "aws_security_group" "vpce_ecr_dkr" {
  description = "To control traffic to and from ECR Docker VPC endpoint"
  name        = "${var.environment}-vpce-ecr-dkr"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpce-ecr-dkr"
    }
  )
}


resource "aws_security_group" "vpce_logs" {
  description = "To control traffic to and from Logs VPC endpoint"
  name        = "${var.environment}-vpce-logs"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpce-logs"
    }
  )
}

resource "aws_security_group" "vpce_s3" {
  description = "To control traffic to and from S3 VPC endpoint"
  name        = "${var.environment}-vpce-s3"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpce-s3"
    }
  )
}

resource "aws_security_group" "vpce_secretsmanager" {
  description = "To control traffic to and from Secret Manager VPC endpoint"
  name        = "${var.environment}-vpce-secretsmanager"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpce-secretsmanager"
    }
  )
}
