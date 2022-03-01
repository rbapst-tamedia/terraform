variable "aws_region" {
  default     = "eu-central-1"
  description = "Define the region where to deploy all the aws elements"
}

terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Repo = "git@github.com/rbapst-tamedia/terraform/aws-iam"
    }
  }
}

data "aws_caller_identity" "current" {}
