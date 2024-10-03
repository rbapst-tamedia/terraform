variable "country_rates" {
  type    = list(string)
  default = ["1-one", "2-two", "3-three", "4-four", "5-five", "6-six", "7-seven", "8-eight", "9-nine", "10-ten"]
}

locals {
  country_rate_chunks = chunklist(var.country_rates, 4)
  country_rate_chunks_map = zipmap(
    range(length(local.country_rate_chunks)),
    local.country_rate_chunks
  )
}

output "crc" {
  value = local.country_rate_chunks
}
output "crcm" {
  value = local.country_rate_chunks_map
}

output "range" {
  value = range(length(local.country_rate_chunks))
}
