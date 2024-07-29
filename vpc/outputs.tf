output "vpc_id" {
  value = aws_vpc.this[0].id
}

output "vpc_arn" {
 value = aws_vpc.this[0].arn
}

output "vpc_cidr" {
 value = aws_vpc.this[0].cidr_block
}