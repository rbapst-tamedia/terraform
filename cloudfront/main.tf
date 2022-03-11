variable "aws_region" {
  default     = "eu-central-1"
  description = "Define the region where to deploy all the aws elements"
}

terraform {
  required_version = "1.0.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "tfstate-sandbox"
    key    = "rba-test/cloudfront/terraform.tfstate"
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      GitHub-Repo = "git@github.com/rbapst-tamedia/terraform/cloudfront"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"

  default_tags {
    tags = {
      GitHub-Repo = "git@github.com/rbapst-tamedia/terraform/cloudfront"
    }
  }
}

data "aws_caller_identity" "current" {}
