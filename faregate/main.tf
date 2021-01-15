variable "aws_region" {
  default     = "eu-west-1"
  description = "Define the region where to deploy all the aws elements"
}

terraform {
  required_providers  {
    aws = {
      source = "hashicorp/aws"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
}

data "aws_caller_identity" "current" {}
