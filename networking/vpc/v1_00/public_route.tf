locals {
  public_tgw_obj = {
    for rte in aws_route_table.public.*.id : rte => [
      for r, v in var.public_tgw_destination_cidr_block : {
        cidr_block = r
        tgw_id     = aws_internet_gateway.this[0].id
      }
    ]
  }
  public_tgw_transformed_list = flatten([
    for rt_id, routes in local.public_tgw_obj : [
      for route in routes : "${rt_id}:${route.cidr_block}:${route.tgw_id}"
    ]
  ])
}

resource "aws_route" "public_default_route" {
  count = length(aws_route_table.public.*.id) > 0 ? length(aws_route_table.public.*.id) : 0

  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.this[0].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "public_tgw_route" {
  #for_each = var.public_subnet_cidrs
  count = length(keys(var.public_tgw_destination_cidr_block))

  route_table_id         = split(":", local.public_tgw_transformed_list[count.index])[0]
  destination_cidr_block = split(":", local.public_tgw_transformed_list[count.index])[1]
  transit_gateway_id        = split(":", local.public_tgw_transformed_list[count.index])[2]

  timeouts {
    create = "5m"
  }
}
