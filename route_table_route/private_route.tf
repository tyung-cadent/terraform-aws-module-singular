locals {
  private_tgw_obj = {
    for rte in aws_route_table.private: rte.id => [
      for r, v in var.tgw_destination_cidr_block : {
        cidr_block = r
        tgw_id     = var.transit_gateway_id
      }
    ]
  }
  private_tgw_transformed_list = flatten([
    for rt_id, routes in local.private_tgw_obj : [
      for route in routes : "${rt_id}:${route.cidr_block}:${route.tgw_id}"
    ]
  ])

  prefix_list_obj = {
    for rte in aws_route_table.private : rte.id => [
      for r, v in var.tgw_destination_prefix_list : {
        prefix_name = r
        tgw_id      = var.transit_gateway_id
      }
    ]
  }
  prefix_transformed_list = flatten([
    for rt_id, routes in local.prefix_list_obj : [
      for route in routes : "${rt_id}:${route.prefix_name}:${route.tgw_id}"
    ]
  ])
}


resource "aws_route" "private_default_route" {
  for_each = var.private_subnet_cidrs

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = var.default_route
  nat_gateway_id         = aws_nat_gateway.nat_gateway[each.key].id

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_tgw_route" {
  #for_each = var.private_subnet_cidrs
  count = length(keys(var.tgw_destination_cidr_block))

  route_table_id         = split(":", local.private_tgw_transformed_list[count.index])[0]
  destination_cidr_block = split(":", local.private_tgw_transformed_list[count.index])[1]
  transit_gateway_id   = split(":", local.private_tgw_transformed_list[count.index])[2]
  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private_prefix_list_route" { 
  #for_each = var.private_subnet_cidrs
  count = length(keys(var.tgw_destination_prefix_list))

  route_table_id             = split(":", local.prefix_transformed_list[count.index])[0]
  destination_prefix_list_id = split(":", local.prefix_transformed_list[count.index])[1]
  transit_gateway_id       = split(":", local.prefix_transformed_list[count.index])[2]
  timeouts {
    create = "5m"
  }
  
}
