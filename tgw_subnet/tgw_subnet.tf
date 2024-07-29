
data "aws_availability_zones" "this" { state = "available" }

locals {
  availability_zone_map = { for idx, az in data.aws_availability_zones.this.names : az => cidrsubnet("${var.vpc_id}.vpc_cidr", 12, idx) }
}

module "tgw_subnets" {
  source        = "../subnet/"
  subnet_cidrs  = local.availability_zone_map
  subnet_vpc_id = var.vpc_id
}

