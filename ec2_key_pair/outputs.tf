################################################################################
# Key Pair
################################################################################

output "key_pair_id" {
  value       = try(aws_key_pair.this[0].key_pair_id, "")
}

output "key_pair_arn" {
  value       = try(aws_key_pair.this[0].arn, "")
}

################################################################################
# Private Key
################################################################################

output "private_key_id" {
  value       = try(tls_private_key.this[0].id, "")
}

output "private_key_openssh" {
  value       = try(trimspace(tls_private_key.this[0].private_key_openssh), "")
  sensitive   = true
}

output "private_key_pem" {
  description = "Private key data in PEM (RFC 1421) format"
  value       = try(trimspace(tls_private_key.this[0].private_key_pem), "")
  sensitive   = true
}

output "public_key_openssh" {
  value       = try(trimspace(tls_private_key.this[0].public_key_openssh), "")
}

output "public_key_pem" {
   value       = try(trimspace(tls_private_key.this[0].public_key_pem), "")
}