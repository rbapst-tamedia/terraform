terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "tf-state-911453050078"
    key            = "rbapst-tamedia/terraform/aws-kinesis/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region         = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"

  default_tags {
    tags = {
      GitHub-Repo = "git@github.com/rbapst-tamedia/terraform/aws-kinesis"
    }
  }
}

data "aws_caller_identity" "current" {}
