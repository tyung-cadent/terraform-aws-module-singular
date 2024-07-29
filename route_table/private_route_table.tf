resource "aws_route_table" "private" {
  for_each = var.private_subnet_cidrs

  vpc_id = aws_vpc.this[0].id

  tags = merge(
    { "Name" = "private_route_table_az${split("-", each.key)[2]}" },
    var.private_route_table_tags,
  )
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnet_cidrs

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

