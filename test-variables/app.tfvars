deployment_env = production
domain_infos = {
  production = {
    domain_name           = "files.newsnetz.ch"
    aliases               = ["mcdn.newsnetz.ch"]
    cloudfront_web_acl_id = "arn:aws:wafv2:us-east-1:883535314275:global/webacl/disco-waf/78059eea-7e4d-4e14-bd2c-0c19bef6f767"
  }
}
