terraform {
  required_version = "~> 1.6.0"

  backend "s3" {
    bucket  = "tfstate-sandbox"
    key     = "examples/terraform/aws/eic.tfstate"
    region  = "eu-central-1"
    encrypt = "true"
    allowed_account_ids = [
      "911453050078"
    ]
  }

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
      Name        = local.name
      Github-Repo = "tx-pts-dai/examples/terraform/aws/eic"
    }
  }
}

locals {
  name       = "aws-eic-example"
  redis_port = 6379
}
