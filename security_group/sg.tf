resource "aws_security_group" "this" {
  count = var.security_group_name != null ? 1 : 0

  name        = var.security_group_name
  description = coalesce(var.security_group_description, "${var.security_group_name}")
  vpc_id      = var.vpc_id
  
  tags = merge(
    { "Name" = "${var.security_group_name}"},
    var.security_group_tags,
  )

}


resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = var.security_group_ingress_rules

  security_group_id = aws_security_group.this[0].id

  cidr_ipv4   = each.value.cidr_ipv4 != "" ? each.value.cidr_ipv4 : null
  description = each.value.description != "" ? each.value.description : null
  from_port   = each.value.from_port != "" ? each.value.from_port : null
  ip_protocol = each.value.ip_protocol != "" ? each.value.ip_protocol : null
  to_port     = each.value.to_port != ""? each.value.to_port : null
  prefix_list_id = each.value.prefix_list_id != "" ? each.value.prefix_list_id : null
  referenced_security_group_id = each.value.referenced_security_group_id != "" ? each.value.referenced_security_group_id : null
}


resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = var.security_group_egress_rules

  security_group_id = aws_security_group.this[0].id

  cidr_ipv4   = each.value.cidr_ipv4 != "" ? each.value.cidr_ipv4 : null
  description = each.value.description != "" ? each.value.description : null
  from_port   = each.value.from_port != "" ? each.value.from_port : null
  ip_protocol = each.value.ip_protocol != "" ? each.value.ip_protocol : null
  to_port     = each.value.to_port != ""? each.value.to_port : null
  prefix_list_id = each.value.prefix_list_id != "" ? each.value.prefix_list_id : null
  referenced_security_group_id = each.value.referenced_security_group_id != "" ? each.value.referenced_security_group_id : null
}