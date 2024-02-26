terraform {
  required_version = "~> 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Github-Repo = "rbapst-tamedia/terraform/faregate"
    }
  }
}
