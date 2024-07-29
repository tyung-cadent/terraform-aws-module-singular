
resource "aws_subnet" "this" {
  for_each = var.subnet_cidrs
   
  vpc_id                  = var.subnet_vpc_id
  cidr_block              = each.value
  map_public_ip_on_launch = false
  availability_zone       = each.key
}

