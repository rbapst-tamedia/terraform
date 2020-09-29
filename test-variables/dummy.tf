resource "null_resource" "test" {
  count = lookup(var.web_acl_map, "development", "") != "" ? 1 : 0
}
