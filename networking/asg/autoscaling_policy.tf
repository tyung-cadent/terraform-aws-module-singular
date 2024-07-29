resource "aws_autoscaling_policy" "vtm_autoscale_policy" {
  count                  = var.TRACKING_QPS_THRESHOLD > 0 ? 1 : 0
  name                   = "${var.CLUSTER_NAME}-tracking-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.adpod.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    customized_metric_specification {
      metric_dimension {
        name  = "cluster"
        value = var.CLUSTER_NAME
      }

      metric_name = var.TRACKING_QPS_METRIC_NAME
      namespace   = var.TRACKING_QPS_METRIC_NAMESPACE
      statistic   = var.TRACKING_QPS_METRIC_STATISTIC
      unit        = " " # A hack to the insufficiant data in cloudwatch metrics
    }

    target_value     = var.TRACKING_QPS_THRESHOLD
    disable_scale_in = var.TRACKING_QPS_METRIC_SCALE_IN

  }
  estimated_instance_warmup = var.TRACKING_QPS_WARMUP_TIME
}


resource "aws_autoscaling_policy" "vtm_cpu_autoscale_policy" {
  count                     = var.TRACKING_CPU_THRESHOLD > 0 ? 1 : 0
  name                      = "${var.CLUSTER_NAME}-cpu-tracking-scaling-policy"
  autoscaling_group_name    = aws_autoscaling_group.adpod.name
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = var.TRACKING_QPS_WARMUP_TIME

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value     = var.TRACKING_CPU_THRESHOLD # 80
    disable_scale_in = true
  }
}
