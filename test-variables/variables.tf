variable "domain_infos" {
  description = "Relevant values for CloudFront and Certificates indexed by landscape"
  type = map(object({
    domain_name           = string
    aliases               = list(string)
    cloudfront_web_acl_id = string
  }))
  default = {
    "production or development or sandbox" = {
      domain_name           = "mydomain.example.com",
      aliases               = ["alias1.example.com", "otheraliase.example.com"],
      cloudfront_web_acl_id = "arn:aws:wafv2:us-east-1:AWS_ACCOUNT_ID:global/webacl/ACL_NAME/ACL_ID"
    }
  }
}
variable "deployment_env" {
  type        = string
  description = "Deployment enviromment (if production, production ready resources will be staged)"
}
