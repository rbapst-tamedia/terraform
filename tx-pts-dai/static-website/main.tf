locals {
  github_repo = "git@github.com:rbapst-tamedia/terraform/tx-pts-dai/static-website"
}

terraform {
  required_version = "~> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Github-Repo = local.github_repo
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"
  default_tags {
    tags = {
      Github-Repo = local.github_repo
    }
  }
}

data "aws_caller_identity" "current" {}
