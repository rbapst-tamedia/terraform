terraform {
  required_version = "~> 1.9.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  # export CLOUDFLARE_API_TOKEN in calling shell or
  # api_token = data.aws_secretsmanager_secret_version.cloudflare_api_token.secret_string --> check disco-infra-terraform/main.tf
}

variable "cloudflare_static_records" {
  description = "list of DNS records to create in CloudFlare"
  type = list(object({
    name    = string
    zone    = string
    content = string
    type    = string
    ttl     = optional(string, "300")
    comment = optional(string, "")
  }))
  default = []
}

data "cloudflare_zone" "this" {
  for_each = { for i, v in var.cloudflare_static_records : "${v.name}-${v.type}-${v.content}-${i}" => v }

  name = each.value.zone
}

resource "cloudflare_record" "this" {
  for_each = { for i, v in var.cloudflare_static_records : "${v.name}-${v.type}-${v.content}-${i}" => v }

  zone_id = data.cloudflare_zone.this[each.key].id
  name    = trimsuffix(trimsuffix(each.value.name, "."), ".${data.cloudflare_zone.this[each.key].name}")
  # name    = each.value.name
  type    = each.value.type
  content = each.value.content
  ttl     = each.value.ttl
  comment = each.value.comment != "" ? each.value.comment : null
  proxied = false

  allow_overwrite = true
}
