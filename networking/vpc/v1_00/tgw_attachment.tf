locals {
    tgw-subnet_id = [ for subnet in aws_subnet.tgw_subnets: subnet.id]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.create_tgw_attachment ? 1 : 0
  
  subnet_ids         = local.tgw-subnet_id
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = aws_vpc.this[0].id
}