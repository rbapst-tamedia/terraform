
web_acl_arn = [
  {
    landscape   = "production"
    web_acl_arn = "arn:aws:wafv2:us-east-1:883535314275:global/webacl/disco-waf/78059eea-7e4d-4e14-bd2c-0c19bef6f767"
  },
  {
    landscape   = "development"
    web_acl_arn = "arn:aws:wafv2:us-east-1:"
  },
  {
    landscape   = "sandbox"
    web_acl_arn = "arn:aws:wafv2:us-east-1:"
  }
]

web_acl_map = {
  "production"  = "arn:aws:wafv2:us-east-1:883535314275:global/webacl/disco-waf/78059eea-7e4d-4e14-bd2c-0c19bef6f767"
  "development" = "arn:aws:wafv2:us-east-1:"
  "sandbox"     = "arn:aws:wafv2:us-east-1:"
}
