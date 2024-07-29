locals {
  # ASG Common tags
  common_tags = {
    Cluster       = var.CLUSTER_NAME
    prommon       = true
    exchange-type = "proxy"
    environment   = var.ENVIRONMENT
    team          = "exchange"
    ncflag        = true
    ssp           = var.CLUSTER_NAME

  }
}

resource "aws_autoscaling_group" "adpod" {
  name                      = "${var.CLUSTER_NAME}-main"
  min_size                  = var.ASG_MIN_SIZE
  max_size                  = var.ASG_MAX_SIZE
  desired_capacity          = var.ASG_DESIRED_SIZE
  health_check_grace_period = 300
  health_check_type         = "EC2"
  termination_policies      = ["OldestInstance"]
  target_group_arns         = [aws_lb_target_group.adpod.arn]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]


  launch_template {
    id      = aws_launch_template.adpod.id
    version = aws_launch_template.adpod.latest_version
  }

  dynamic "tag" {
    for_each = local.common_tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  initial_lifecycle_hook {
    name                 = "launch-${var.CLUSTER_NAME}"
    default_result       = "ABANDON"
    heartbeat_timeout    = 120
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"
  }

  initial_lifecycle_hook {
    name                 = "terminate-${var.CLUSTER_NAME}"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 300
    lifecycle_transition = "autoscaling:EC2_INSTANCE_TERMINATING"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      desired_capacity
    ]
  }

  depends_on = [
    aws_launch_template.adpod,
    aws_lb.adpod,
    aws_lb_target_group.adpod
  ]
}


resource "aws_autoscaling_attachment" "adpod_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.adpod.id
  lb_target_group_arn    = aws_lb_target_group.adpod.arn
}

