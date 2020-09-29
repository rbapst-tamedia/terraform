variable "web_acl_arn" {
  description = "web_acl_arn for the diffenrent clusters"
  default     = []
  type = list(object({
    landscape   = string
    web_acl_arn = string
  }))
}
variable "web_acl_map" {
  type = map(string)
  default = {
    "production"  = "P1",
    "development" = "D2",
    "sandbox"     = "S3"
  }
}
