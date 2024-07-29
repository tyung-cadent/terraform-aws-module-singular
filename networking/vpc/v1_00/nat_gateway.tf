resource "aws_eip" "nat" {
  for_each  = var.public_subnet_cidrs

  domain = "vpc"

  tags = merge(
    { "Name" = "nat_gateway_${each.key}_eip" }
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.public_subnet_cidrs

  subnet_id         = aws_subnet.public[each.key].id
  connectivity_type = var.nat_gateway_connectivity_type
  allocation_id     = aws_eip.nat[each.key].id

  tags = merge(
    { "Name" = "nat_gateway_${each.value}}" },
    var.nat_gateway_tags,
  )
  depends_on = [
    aws_eip.nat,
    aws_subnet.public,
    aws_internet_gateway.this
  ]
}