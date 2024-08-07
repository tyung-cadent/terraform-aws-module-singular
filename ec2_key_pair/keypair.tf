resource "aws_key_pair" "this" {
  count = var.create_keypair ? 1 : 0

  key_name        = var.keypair_name
  public_key      = var.create_private_key ? trimspace(tls_private_key.this[0].public_key_openssh) : var.provided_public_key

  tags = var.tags
}