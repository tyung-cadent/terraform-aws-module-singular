
resource "aws_subnet" "tgw_subnets" {
  count = var.create_tgw_subnets ? length(data.aws_availability_zones.this.names) : 0

  cidr_block        = cidrsubnet(aws_vpc.this[0].cidr_block, 12, count.index)
  vpc_id            = aws_vpc.this[0].id
  availability_zone = data.aws_availability_zones.this.names[count.index]

  tags = merge(
    { "Name" = "tgw_subnet_az${split("-", data.aws_availability_zones.this.names[count.index])[2]}" },
    var.tgw_tags
  )

  depends_on = [
    aws_vpc.this[0]
  ]
}
