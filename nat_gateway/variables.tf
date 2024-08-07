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
  default = true
}

variable "igw_tags" {
  type    = map(string)
  default = {}
}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}

variable "public_subnet_cidrs" {
  description = "key is az name, value is cidr range. ie {us-east-1a: \"10.160.16.0/20\"}"
  type        = map(string)
  default     = {}
}