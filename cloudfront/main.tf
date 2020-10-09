variable "aws_region" {
  default     = "eu-central-1"
  description = "Define the region where to deploy all the aws elements"
}

provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
  alias   = "us"
}

data "aws_caller_identity" "current" {}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"
  config = {
    bucket = "tf-state-${data.aws_caller_identity.current.account_id}"
    key    = "infrastructure/terraform.tfstate"
  }
}
