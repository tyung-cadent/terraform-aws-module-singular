output "dhcp_option_set_id" {
  value = aws_vpc_dhcp_options.this[0].id
}

output "dhcp_option_set_arn" {
 value = aws_vpc_dhcp_options.this[0].arn
}


output "dhcp_option_set_owner_id" {
 value = aws_vpc_dhcp_options.this[0].owner_id
}