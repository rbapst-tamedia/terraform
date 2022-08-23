#
# Configuration terraform (version, providers à utiliser)
#
terraform {
  required_version = "1.0.11"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~ 3.68.0"
    }
  }
}

#
# Configuration des providers
#

# Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Landscape   = var.environment
      Github-Repo = var.github_repo
    }
  }
}

#
# Variables
#

#
# Locals (pratique pour faire des "calculs")
#
locals {
  allowed_ips = [
    for ip in split("\n", data.local_file.waf_allowed_ips.content) :
    format("%s/32", regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}", ip))
    if ip != ""
  ]

  array_of_records = [
    {
      username = "Roland_Bapst",
      email    = "roland.bapst@tx.group",
    }
  ]
}

#
# Ressources
#

# Doc: https://registry.terraform.io/providers/hashicorp/random/3.3.2
resource "random_pet" "this" {
  length  = 1
}

# Doc: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "this" {
  content  = "une ligne!"
  filename = "${path.module}/mon_fichier.txt"
}

resource "local_file" "foo" {
  for_each = { for record in local.array_of_records : record.username => record }

  content  = each.value.email
  filename = "${path.module}/${each.value.username}.txt"
}

resource "local_file" "bar" {
  for_each = local_file.foo

  content  = each.value.content
  filename = "${each.value.filename}-2-${each.key}"
}

#
# Data
#
data "local_file" "waf_allowed_ips" {
  filename = "${path.module}/waf_allowed_ips.txt"
}

