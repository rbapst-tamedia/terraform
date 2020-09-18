locals {
  list1 = [
    {
      name = "first element"
      value = "1"
    },
    {
      name = "second element"
      aws  = "2"
    }
  ]
  list2 = [
    {
      id = "first id"
      domain = "first.ch"
    },
    {
      id = "second id"
      domain = "second.ch"
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
  for_each = {
    for element in local.list1 : element.name [
      for domain in local.list2 : concat(element.name, domain.id) => {
	name = element.name
	aws = element.aws
	id = domain.id
	domain = domain.domain
      }
    ]
  }
  bucket = each.value.name
  acl    = "private"
  tags = {
    owner = each.value.domain
  }
}

  
