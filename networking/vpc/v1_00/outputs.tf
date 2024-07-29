output "availability_zone_names" {
  value = local.availability_zone_names
}

output "availability_zone_ids" {
  value = local.availability_zone_ids
}

output "eip_addresses" {
  value = [for ip in aws_eip.nat: ip.public_ip ]
}

output "eip_ids" {
  value = [for ip in aws_eip.nat: ip.id ]
}

output "tgw_subnet_id" {
  value = [ for subnet_id in aws_subnet.tgw_subnets: subnet_id.id]
}

output "private_subnets" {
  value = { for k, private in aws_subnet.private: k => private.id}
}

output "public_subnets" {
  value = { for k, public in aws_subnet.public: k => public.id}
}

output "nat_gateway" {
  value = { for k, nat in aws_nat_gateway.nat_gateway: k => nat.id}
}

output "private_route_table" {
  value = { for k, rte in aws_route_table.private: k => rte.id}
}

output "public_route_table" {
  value = { for k, rte in aws_route_table.public: k => rte.id}
}

output "private_tgw_obj" {
  value = local.private_tgw_obj
}

output "private_tgw_transformed_list" {
  value = local.private_tgw_transformed_list
}

output "prefix_list_obj" {
  value = local.prefix_list_obj
}

output "prefix_transformed_list" {
  value = local.prefix_transformed_list
}

output "public_tgw_obj" {
  value = local.public_tgw_obj
}

output"public_tgw_transformed_list" {
  value = local.public_tgw_transformed_list
}