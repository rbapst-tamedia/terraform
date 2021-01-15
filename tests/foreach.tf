locals {
  list1 = [
    {
      name = "first element"
      value = "1"
      todo = true
    },
    {
      name = "second element"
      aws  = "2"
      todo = false
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

variable "configs1" {
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

output "values" {
  value = {
    for element in local.list1 :
    element.name => element
    if element.todo
  }
}

  
