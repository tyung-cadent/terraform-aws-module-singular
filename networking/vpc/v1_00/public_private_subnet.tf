locals {
  availability_zone_names = data.aws_availability_zones.this.names
  availability_zone_ids   = data.aws_availability_zones.this.zone_ids
}


resource "aws_subnet" "private" {
  for_each = var.private_subnet_cidrs
  
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = each.key  #try(element(local.availability_zone_names, each.key - 1), element(local.availability_zone_names, 0))

  depends_on = [
    aws_vpc.this
  ]

  tags = merge(
    { "Name" = "${var.vpc_name}_private_az${split("-", each.key)[2]}" },
    var.subnet_tags
  )
}


resource "aws_subnet" "public" {
  for_each = var.public_subnet_cidrs

  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = each.key #try(element(local.availability_zone_names, each.key - 1), element(local.availability_zone_names, 0))

  depends_on = [
    aws_vpc.this
  ]

  tags = merge(
    { "Name" = "${var.vpc_name}_public_az${split("-", each.key)[2]}" },
    var.subnet_tags
  )
}
