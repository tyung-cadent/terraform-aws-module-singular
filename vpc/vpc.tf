resource "aws_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    { "Name" = var.vpc_name },
    var.vpc_tags,
  )
}

resource "aws_vpc_dhcp_options_association" "this" {
  
  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = var.dhcp_option_set_id
}