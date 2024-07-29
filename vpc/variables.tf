variable "create_vpc" {}
variable "vpc_cidr" {}
variable "vpc_tags" {}
variable "vpc_name" {}
variable "dhcp_option_set_id" {}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

