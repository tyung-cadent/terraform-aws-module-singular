variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "env" {
  type    = string
  default = "dev"
}

################################################################################
# Security Group (sg)
################################################################################
variable "vpc_id" {}

variable "security_group_name" {}

variable "security_group_description" {}

variable "security_group_tags"   {}

variable "security_group_ingress_rules" {}

variable "security_group_egress_rules" {}