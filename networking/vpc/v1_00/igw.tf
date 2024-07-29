resource "aws_internet_gateway" "this" {
  count = var.create_igw ? 1 : 0
  
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    { "Name" = "${var.vpc_name}_igw" },
    var.igw_tags,
  )
}
