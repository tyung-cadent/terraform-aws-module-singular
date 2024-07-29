locals {
    route_table = [ for rte in aws_route_table.private: rte.id]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.this[0].id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids   = local.route_table
  vpc_endpoint_type = "Gateway"

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*",
      "Principal": "*"
    }
  ]
}
POLICY

 tags = merge(
    { "Name" = "S3_gateway_endpoint_${var.aws_region}" },
   
  )
  }