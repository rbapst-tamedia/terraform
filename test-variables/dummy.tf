locals {
  domain_name = contains(keys(var.domain_infos), var.deployment_env) ? var.domain_infos.var.deployment_env.domain_name : ""
}

resource "null_resource" "test" {
  count = lookup(var.domain_infos, var.deployment_env, null) != null ? 1 : 0
}
output "domain_name" {
  value = local.domain_name
}
