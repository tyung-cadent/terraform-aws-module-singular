resource "aws_ssm_parameter" "this" {
  count = var.create_private_key ? 1 : 0

  name        = "/ec2_keypair/private/${aws_key_pair.this[0].key_name}"
  description = "${var.keypair_name} EC2 Key Pair Private Key"
  type        = "SecureString"
  value       = tls_private_key.this[0].private_key_pem
  tier        = "Standard"
}
