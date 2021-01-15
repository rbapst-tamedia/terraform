terraform {
  backend "local" {
  }
}
locals {
  pingdomIPUrl = "https://my.pingdom.com/probes/ipv4"
  pingdomIps = [
    for ip in split("\n", data.http.pingdomipv4.body) :
    format("%s/32", ip)
    if ip != ""
  ]
}
data "http" "pingdomipv4" {
  url = local.pingdomIPUrl
  request_headers = {
    Accept = "text/*"
  }
}
output "ips" {
  value = local.pingdomIps
}
