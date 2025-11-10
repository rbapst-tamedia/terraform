terraform {
  required_version = "~> 1.13.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Name       = local.name
      GithubRepo = "rbapst-tamedia/terraform/aws-ssm"
      Created    = "manually"
    }
  }
}

locals {
  name = "aws-ssm-example"
}
