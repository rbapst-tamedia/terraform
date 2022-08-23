locals {
  # Admin urls:
  # - PROD: admin.publishing.tamedia.ch
  # - DEV: admin-master.dev.tamedia.ch (will be admin.static.dev.tamedia.ch or, if possible, admin.dev.tamedia.ch)
  # - STAGING: admin-staging.dev.tamedia.ch (will be admin-staging.static.dev.tamedia.ch or, if possible, admin-staging.dev.tamedia.ch)
  # - FEATURE-BRANCH admin-<<branch>>.dev.tamedia.ch (will be admin-<<branch>>.dev.tamedia.ch)
  #                     DEPLOYMENT ENV
  # BRANCH            | production                  | any other
  # ------------------+-----------------------------+-------------------
  #    master         | admin.publishing.tamedia.ch | admin.dev.tamedia.ch
  #    staging        | -                           | admin-staging.dev.tamedia.ch
  #    DISC-*         | -                           | admin-disc-*.dev.tamedia.ch
  # ------------------+-----------------------------+-------------------
  admin_ingress_host = var.deployment_env == "production" ? (var.branch == "master" ? "admin.publishing.tamedia.ch" : "-") : (var.branch == "master" ? "admin.dev.tamedia.ch" : "admin-${lower(var.branch)}dev.tamedia.ch")
}

variable "branch" {
  type = string
}

variable "deployment_env" {
  type = string
}

output "admin" {
  value = local.admin_ingress_host
}
