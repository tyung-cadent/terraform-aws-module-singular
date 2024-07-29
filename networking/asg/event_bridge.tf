resource "aws_cloudwatch_event_rule" "adpod" {
  name          = "${var.CLUSTER_NAME}-ASG-bootstrap"
  description   = "Runs on every new ASG instance"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.autoscaling"
  ],
  "detail-type": [
    "EC2 Instance Launch Successful",
    "EC2 Instance Terminate Successful",
    "EC2 Instance Launch Unsuccessful",
    "EC2 Instance Terminate Unsuccessful",
    "EC2 Instance-launch Lifecycle Action",
    "EC2 Instance-terminate Lifecycle Action"
  ],
  "detail": {
    "AutoScalingGroupName": [
      "${var.CLUSTER_NAME}-main",
      "${var.CLUSTER_NAME}-spot",
      "${var.CLUSTER_NAME}-cnry"
    ]
  }
}
PATTERN
}

data "aws_lambda_function" "vtm_lambda" {
  function_name = var.VTM_LAMBDA_NAME
}

resource "aws_cloudwatch_event_target" "lambda_bootstrap" {
  rule      = aws_cloudwatch_event_rule.adpod.name
  target_id = "lambda"
  arn       = data.aws_lambda_function.vtm_lambda.arn
}
