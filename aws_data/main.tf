terraform {
  required_version = "~> 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_caller_identity" "current" {}

output "account_id" {
  description = "AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "terraform_path_module" {
  description = "path.module directory"
  value       = path.module
}

output "terraform_path_root" {
  description = "path.dir directory"
  value       = path.root
}

output "terraform_path_cwd" {
  description = "path.cwd directory"
  value       = path.cwd
}

output "terraform_terraform_workspace" {
  description = "Terraform workspace"
  value       = terraform.workspace
}

data "aws_nat_gateways" "this" {
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_nat_gateway" "this" {
  count = length(data.aws_nat_gateways.this.ids)
  id    = tolist(data.aws_nat_gateways.this.ids)[count.index]
}

locals {
  nat_gateways_ips = [for nat_gateway in data.aws_nat_gateway.this :
    format("%s/32", nat_gateway.public_ip)
  ]
}

output "nat_gateways" {
  value = data.aws_nat_gateway.this
}

output "nat_gatewyays_2" {
  value = local.nat_gateways_ips
}

data "aws_ec2_instance_type" "this" {
  for_each = toset([
    "t3.small",
    "t4g.small"
  ])
  instance_type = each.key
}

output "instances" {
  value = [for v in data.aws_ec2_instance_type.this : v.supported_architectures]
}
