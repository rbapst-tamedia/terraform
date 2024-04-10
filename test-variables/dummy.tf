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
