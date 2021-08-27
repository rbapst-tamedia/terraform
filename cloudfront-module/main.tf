## Main work
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      owner  = "roland"
      create = "terraform"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"
  default_tags {
    tags = {
      owner  = "roland"
      create = "terraform"
    }
  }
}

data "aws_caller_identity" "current" {}
