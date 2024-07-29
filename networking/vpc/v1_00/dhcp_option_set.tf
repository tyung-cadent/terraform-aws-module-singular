resource "aws_vpc_dhcp_options" "this" {
  count = var.create_dhcp_options ? 1 : 0
  
  domain_name          = var.aws_region == "us-east-1" ? "ec2.internal" : "${var.aws_region}.compute.internal}"
  domain_name_servers  = var.dhcp_options_domain_name_servers
  ntp_servers          = var.dhcp_options_ntp_servers
  netbios_name_servers = var.dhcp_options_netbios_name_servers
  netbios_node_type    = var.dhcp_options_netbios_node_type

  tags = merge(
    { "Name" = "${var.vpc_name}-dhcp-option-set" },
    var.dhcp_options_tags,
  )
}
