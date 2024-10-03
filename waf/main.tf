terraform {
  required_version = "1.6.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "tf-state-911453050078"
    key    = "rbapst-tamedia/terrafrom/waf/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "us"

  default_tags {
    tags = {
      GitHub-Repo = "git@github.com/rbapst-tamedia/terraform/waf"
    }
  }
}
