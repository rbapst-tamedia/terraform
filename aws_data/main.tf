terraform {
  required_version = "~> 1.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

data "aws_caller_identity" "current" {}

data "aws_regions" "enabled" {}

data "aws_lambda_functions" "all" {
  for_each = toset(data.aws_regions.enabled.names)

  region = each.key
}

locals {
  datadog_log_forwarder_name = "datadog-log-forwarder"

  regions_with_forwarders = [
    for region, lambdas in data.aws_lambda_functions.all : region
    if contains(lambdas.function_names, local.datadog_log_forwarder_name)
  ]
}

data "aws_lambda_function" "forwarder" {
  for_each = toset(local.regions_with_forwarders)

  region        = each.key
  function_name = local.datadog_log_forwarder_name
}

output "lambdas" {
  value = {
    for region, lambda in data.aws_lambda_function.forwarder : region => lambda.arn
  }
}

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
