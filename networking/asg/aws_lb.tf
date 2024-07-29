resource "aws_lb" "adpod" {
  name                       = "${var.CLUSTER_NAME}-alb"
  internal                   = var.LB_INTERNAL
  load_balancer_type         = var.LB_TYPE
  idle_timeout               = 3600
  security_groups            = var.LB_SECURITY_GROUP
  subnets                    = var.LB_SUBNETS
  enable_deletion_protection = false
  drop_invalid_header_fields = true

}

resource "aws_lb_target_group" "adpod" {
  name        = "${var.CLUSTER_NAME}-target"
  port        = var.LB_TARGET_GROUP_PORT
  vpc_id      = var.LB_VPC
  protocol    = "HTTP"
  target_type = var.LB_TARGET_TYPE
  health_check {
    path    = var.LB_HEALTHCHECK_PATH
    matcher = "200-499"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.adpod.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    #   target_group_arn = aws_lb_target_group.adpod.arn
    #   type             = "forward"

    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.adpod.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.LB_SSL_POLICY
  certificate_arn   = var.LB_LISTENER_CERT
  default_action {
    target_group_arn = aws_lb_target_group.adpod.arn
    type             = "forward"
  }
}

