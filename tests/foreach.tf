locals {
  allowed_ips = [
    for ip in split("\n", data.local_file.waf_allowed_ips.content) :
    format("%s/32", regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}", ip))
    if ip != ""
  ]
  addons = {
    un-deux: "un-deux",
    un_deux: "un_dexu"
  }
  replace_char = "Un-deux/1.x"
}

data "local_file" "waf_allowed_ips" {
  filename = "${path.module}/waf_allowed_ips.txt"
}

output "only_letters" {
  value = replace(replace(local.replace_char, "/", ""), ".", "")
}
