variable "aws_region" {
  type    = string
  default = "us-east-1"
}

################################################################################
# DHCP Options Set
################################################################################
variable "create_dhcp_options" {}

variable "dhcp_options_domain_name_servers" {}

variable "dhcp_options_name" {}
