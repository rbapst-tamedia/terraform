locals {
  allowed_ips = [
    for ip in split("\n", data.local_file.waf_allowed_ips.content) :
    format("%s/32", regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}", ip))
    if ip != ""
  ]
}

data "local_file" "waf_allowed_ips" {
  filename = "${path.module}/waf_allowed_ips.txt"
}

output "values" {
  value = local.allowed_ips
}


