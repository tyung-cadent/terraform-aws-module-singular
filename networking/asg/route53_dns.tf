data "aws_route53_zone" "local_emxdgt_com_zone" {
  name         = "local.emxdgt.com."
  private_zone = false
}

# Creating the cluster level a record Public ips
resource "aws_route53_record" "cluster_local_emxdgt_com_record" {
  zone_id = data.aws_route53_zone.local_emxdgt_com_zone.zone_id
  name    = "${var.CLUSTER_NAME}.${var.REGION}"
  type    = "A"
  ttl     = "10"
  records = ["127.0.0.1"]

  lifecycle {
    ignore_changes = [
      records,
    ]
  }
}

# Creating the cluster level a record Private ips
resource "aws_route53_record" "privte_cluster_local_emxdgt_com_record" {
  zone_id = data.aws_route53_zone.local_emxdgt_com_zone.zone_id
  name    = "${var.CLUSTER_NAME}-lb.${var.REGION}"
  type    = "A"
  ttl     = "10"
  records = ["127.0.0.1"]

  lifecycle {
    ignore_changes = [
      records,
    ]
  }
}
