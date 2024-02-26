locals {
  string = "Jame-with-and-chars"
  normalized = join("-", regexall("[^._]*", lower(local.string)))
}

output "nor0" {
  value = local.string
}
output "nor" {
  value = local.normalized
}
