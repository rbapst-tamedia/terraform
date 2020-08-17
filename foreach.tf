locals {
  configs = [
    {
      name = "roland 1"
      aws  = "1"
    },
    {
      name = "roland"
      aws  = "asdasafdsf"
    }
  ]
}


variable "configs" {
  description = "Ma configuration"
  default = [
    {
      name = "roland 1"
      aws  = "1"
    },
    {
      name = "roland"
      aws  = "asdasafdsf"
    }
  ]
}

variable "configs2" {
  description = "Ma configuration"
  default = {
    config_1 = {
      name = "roland 1"
      aws  = "aws1"
    }
    confidfgfdagagg_2 = {
      name = "roland"
      aws  = "asdasafdsf"
    }
    toto = {
      name = "roland3"
      aws  = "3"
    }
  }
}

resource "aws_s3_bucket" "bucket_for" {
  for_each = { for s in var.configs : s.name => s }
  #  for_each = var.configs2

  bucket = each.value.name
  acl    = "private"
  tags = {
    owner = each.value.aws
  }
}
