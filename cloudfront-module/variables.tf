variable "dns_domain_names" {
  type        = list(string)
  description = "name of the DNS domain hosted zone that will be create for the environment"
  default     = ["dummy.r0l1.ch"]
}
