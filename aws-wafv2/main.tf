terraform {
  required_version = "1.0.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

data "aws_canonical_user_id" "current" {}

variable "github_repo" {
  default = "https://github.com/rbapst-tamedia/terraform/aws-wafv2"
}

provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Github-Repo = var.github_repo
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "global"
  default_tags {
    tags = {
      Github-Repo = var.github_repo
    }
  }
}
