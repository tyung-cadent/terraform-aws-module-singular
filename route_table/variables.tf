variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  type    = string
  default = "dev"
}

################################################################################
# Transit Gateway(tgw) Subnets
################################################################################
variable "create_tgw_attachment" {
  type    = bool
  default = false
}

variable "create_tgw_subnets" {
  type    = bool
  default = false
}

variable "tgw_tags" {
  type    = map(string)
  default = {}
}
  

################################################################################
# DHCP Options Set
################################################################################
variable "create_dhcp_options" {
  type    = bool
  default = false
}

variable "dhcp_options_domain_name_servers" {
  type    = list(string)
  default = ["AmazonProvidedDNS"]
}

variable "dhcp_options_ntp_servers" {
  type    = list(string)
  default = []
}

variable "dhcp_options_netbios_name_servers" {
  type    = list(string)
  default = []
}

variable "dhcp_options_netbios_node_type" {
  type    = string
  default = ""
}

variable "dhcp_options_tags" {
  type    = map(string)
  default = {}
}

variable "dhcp_options_name" {
  type    = string
  default = ""
}

################################################################################
# VPC
################################################################################
variable "create_vpc" {
  type    = bool
  default = false
}

variable "vpc_cidr" {
  type    = string
  default = ""
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "vpc_tags" {
  type    = map(string)
  default = {}
}

variable "vpc_name" {
  type    = string
  default = ""
}

# variable "dhcp_option_set_id" {
#   type    = string
#   default = ""
# }

################################################################################
# Subnets
################################################################################
variable "create_private_subnets" {
  type    = bool
  default = false
}

variable "create_public_subnets" {
  type    = bool
  default = false
}

variable "private_subnet_cidrs" {
  type    = map(string)
  default = {}
}

variable "public_subnet_cidrs" {
  type    = map(string)
  default = {}
}

variable "subnet_tags" {
  type    = map(string)
  default = {}
}
  

################################################################################
# NAT and Internet gateways
################################################################################
variable "create_nat_gateway" {
  type    = bool
  default = false
}

variable "nat_gateway_connectivity_type" {
  type    = string
  default = "public"
}

variable "create_igw" {
  type    = bool
  default = false
}

variable "igw_tags" {
  type    = map(string)
  default = {}
}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}

################################################################################
# Routes
################################################################################
variable "default_route" {
  type    = string
  default = ""
}

variable "tgw_destination_cidr_block" {
  type    = map(string)
  default = {}
}

variable "tgw_destination_prefix_list" {
  type    = map(string)
  default = {}
}

variable "public_tgw_destination_cidr_block" {
  type    = map(string)
  default = {}
}

variable "private_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "public_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "transit_gateway_id" {
  type = string
  default = ""  
}