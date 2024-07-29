data "aws_ssm_parameter" "vtm_ssm_passwd" {
  name            = var.VTM_SSM_PASSWD_PATH
  with_decryption = true
}

data "aws_ssm_parameter" "sd_ssm_passwd" {
  name            = var.SD_SSM_PASSWD_PATH
  with_decryption = true
}

locals {
  vtm_password = data.aws_ssm_parameter.vtm_ssm_passwd.value
  sd_password  = data.aws_ssm_parameter.sd_ssm_passwd.value
}

locals {
  vtm-userdata = <<EOF
bandwidth=${var.BANDWIDTH_LICENSE_ALLOCATION} sdpassword=${local.sd_password} sd=true password=${local.vtm_password} accept_license=yes timezone=UTC cluster_fingerprint=unsafe environment=${var.ENVIRONMENT} team=${var.TEAM} cluster_name=${var.CLUSTER_NAME} conf_cluster_name=${var.CLUSTER_NAME} cluster_chef_role=${var.CLUSTER_CHEF_ROLE}
EOF
}

resource "aws_launch_template" "adpod" {
  name          = "${var.CLUSTER_NAME}-lt"
  description   = "Launch Template for ${var.CLUSTER_NAME} ASG"
  image_id      = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name      = var.KEY_NAME

  block_device_mappings {
    device_name = var.ROOT_DEVICE_NAME

    ebs {
      volume_size           = var.ROOT_VOLUME_SIZE
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }


  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.LT_SUBNET_ID
    security_groups             = var.VPC_SECURITY_GROUP_IDS
  }

  iam_instance_profile {
    name = var.INSTANCE_PROFILE_NAME
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  user_data = base64encode(local.vtm-userdata)

}
