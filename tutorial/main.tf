#
# Configuration terraform (version, providers à utiliser)
#
terraform {
  required_version = "1.0.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  #  backend "s3" {
  #    bucket = "rba-state-bucket"
  #    key = "terraform/tutorial/terraform.tfstate"
  #    dynamodb_table = "terraform-lock"
  #  }
}

#
# Configuration des providers
#

# Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Github-Repo = var.github_repo
    }
  }
}
