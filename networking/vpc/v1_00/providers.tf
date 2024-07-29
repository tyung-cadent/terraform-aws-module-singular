terraform {
  required_version = ">= 1.9.0"
  # backend "s3" {
  #   region = var.aws_region
  #   dynamodb_table = "terraform-state-locking"
  #   encrypt        = true
  #}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      env       =  var.env
      terraform = "true"
    }
  }
}