locals {
  domain_name  = contains(keys(var.domain_infos), var.deployment_env) ? var.domain_infos.var.deployment_env.domain_name : ""
  release_name = "toto"
  service_name = local.release_name
}

resource "null_resource" "test" {
  count = lookup(var.domain_infos, var.deployment_env, null) != null ? 1 : 0
}
output "service_name" {
  value = local.service_name
}
output "domain_name" {
  value = local.domain_name
}
