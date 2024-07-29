variable "REGION" {
  type    = string
  default = "us-east-1"
}

variable "ENVIRONMENT" {
  type    = string
  default = "prod"
}

variable "TEAM" {
  type        = string
  description = "Owner team"
  default     = "exchange"
}

variable "CLUSTER_NAME" {
  type    = string
  default = "proxy-adpod-east-1"
}

variable "CLUSTER_CHEF_ROLE" {
  type    = string
  default = "nc_proxy_chef_client_base_role"
}

################ Applicaiton Load Balancer #################
variable "LB_SECURITY_GROUP" {
  type    = list(string)
  default = []
}

variable "LB_TYPE" {
  type    = string
  default = "application"
}

variable "LB_INTERNAL" {
  type    = bool
  default = false
}

variable "LB_SUBNETS" {
  type    = list(string)
  default = []
}

variable "LB_VPC" {
  type    = string
  default = ""
}

variable "LB_TARGET_TYPE" {
  type    = string
  default = "instance"
}

variable "LB_HEALTHCHECK_PATH" {
  type    = string
  default = "/"
}

variable "LB_TARGET_GROUP_PORT" {
  type    = number
  default = 80
}


variable "LB_LISTENER_CERT" {
  type    = string
  default = ""
}

variable "LB_SSL_POLICY" {
  type    = string
  default = "ELBSecurityPolicy-TLS13-1-2-2021-06"
}


################# Autoscaling group ################
variable "ASG_DESIRED_SIZE" {
  type    = number
  default = 2
}

variable "ASG_MIN_SIZE" {
  type    = number
  default = 2
}

variable "ASG_MAX_SIZE" {
  type    = number
  default = 2
}


################# Event Bridge ################
variable "VTM_LAMBDA_NAME" {
  type    = string
  default = "vtm_asg_lambda"
}


################# Launch Template ################

variable "AMI_ID" {
  type    = string
  default = "ami-03bbcb9eca7ab0020"
}

variable "BANDWIDTH_LICENSE_ALLOCATION" {
  type    = number
  default = 230
}

variable "ROOT_DEVICE_NAME" {
  type    = string
  default = "/dev/xvda"
}

variable "ROOT_VOLUME_SIZE" {
  type    = number
  default = 30
}

variable "INSTANCE_TYPE" {
  type    = string
  default = "c5.9xlarge"
}

variable "KEY_NAME" {
  type    = string
  default = "rundeck"
}

variable "INSTANCE_PROFILE_NAME" {
  type    = string
  default = "ec2-s3-brtpublic"
}

variable "LT_SUBNET_ID" {
  type    = string
  default = ""
}

variable "VPC_SECURITY_GROUP_IDS" {
  type    = list(string)
  default = []
}

variable "VTM_SSM_PASSWD_PATH" {
  type    = string
  default = "/prod/infra/vtm/admin/password"
}

variable "SD_SSM_PASSWD_PATH" {
  type    = string
  default = "/prod/infra/services-director/admin/password"
}


################## ASG Policy  #######################
variable "TRACKING_QPS_THRESHOLD" {
  type        = number
  description = "Desired max QPS per server. 0 means no tracking policy"
  default     = 0
}

variable "TRACKING_QPS_METRIC_NAMESPACE" {
  type        = string
  description = "Cloudwatch metric Namespace"
  default     = "VtmExchange"
}

variable "TRACKING_QPS_METRIC_STATISTIC" {
  type        = string
  description = "Cloudwatch metric statistic function [Average,Maximum]"
  default     = "Average"
}

variable "TRACKING_QPS_METRIC_SCALE_IN" {
  type        = bool
  description = "Disable scale in"
  default     = false
}

variable "TRACKING_QPS_WARMUP_TIME" {
  type        = number
  description = "ASG instance warmup time"
  default     = 800
}

variable "TRACKING_CPU_THRESHOLD" {
  type        = number
  description = "Desired avg cpu per server. 0 means no tracking policy"
  default     = 80
}

variable "TRACKING_QPS_METRIC_NAME" {
  type        = string
  description = "Cloudwatch metric name"
  default     = "ClusterQPS"
}



