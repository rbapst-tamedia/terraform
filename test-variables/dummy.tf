locals {
  deploy_random = var.test_bool == null ? false : true
}

variable "test_bool" {
  description = "test with var = null/true/false"
  type        = bool
  default     = null
}

resource "random_pet" "this" {
  count  = local.deploy_random ? 1 : 0
  length = 10
  prefix = var.test_bool ? "t-" : "f-"
}

output "test_bool" {
  value = local.deploy_random ? random_pet.this[0].id : "-"
}

locals {
  long_array        = ["1", "2", "3", "4", "5", "6", "7"]
  one_element_array = ["one"]
}

output "var_test_bool" {
  description = "Value of var.test_bool"
  value       = var.test_bool
}

output "test_chunk" {
  value = chunklist(local.long_array, 4)
}

output "test_one_element" {
  value = {
    car = local.one_element_array[0]
    crd = length(local.one_element_array) > 1 ? slice(local.one_element_array, 1, length(local.one_element_array) - 1) : []
  }
}
