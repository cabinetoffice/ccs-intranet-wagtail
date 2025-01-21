
resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.this.default_route_table_id
  tags                   = merge(var.tags, { Name = "${var.environment}-default" })
}

resource "aws_route_table" "public" {
  count = length(var.vpc_public_subnets)

  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.environment}-public-${element(var.vpc_azs, count.index)}"
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.environment}-private"
  })
}
