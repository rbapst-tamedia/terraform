## Variables
variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
}
variable "domain_name" {
  description = "The domain name corresponding to the distribution"
  type        = string
}
variable "cloudfront_web_acl_id" {
  description = "Id of the web_acl to attach"
  default     = null
}
variable "cloudfront_custom_origins" {
  type        = list(map(string))
  description = "A list of maps which configure the cloudfront custom origins. A primary one is pre-defined."
  default     = []
}
variable "cloudfront_origin_groups" {
  description = "A list of maps containing the origin groups."
  default     = []
  type = list(object({
    id           = string
    status_codes = list(number)
    member1      = string
    member2      = string
  }))
}
## Locals (to event. put in vars)
locals {
  comment                                                     = "CF for files.newsnetz.ch"
  enabled                                                     = true
  http_version                                                = "http2"
  retain_on_delete                                            = false
  wait_for_deployment                                         = false
  cloudfront_default_custom_origin_path                       = ""
  cloudfront_default_custom_origin_http_port                  = 80
  cloudfront_default_custom_origin_https_port                 = 443
  cloudfront_default_custom_origin_keepalive_timeout          = 60
  cloudfront_default_custom_origin_read_timeout               = 60
  cloudfront_default_custom_origin_protocol_policy            = "https-only"
  cloudfront_default_custom_origin_ssl_protocols              = ["TLSv1.2"]
  cloudfront_default_cache_behavior_allowed_methods           = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
  cloudfront_default_cache_behavior_cached_methods            = ["GET", "HEAD", "OPTIONS"]
  cloudfront_default_cache_behavior_target_origin_id          = "default"
  cloudfront_default_cache_behavior_compress                  = true
  cloudfront_default_cache_behavior_viewer_protocol_policy    = "redirect-to-https"
  cloudfront_default_cache_behavior_min_ttl                   = 0
  cloudfront_default_cache_behavior_default_ttl               = 0
  cloudfront_default_cache_behavior_max_ttl                   = 31536000 # 1 year
  cloudfront_default_cache_behavior_query_string              = true
  cloudfront_default_cache_behavior_cookies_forward           = "all"
  cloudfront_default_cache_behavior_cookies_whitelisted_names = []
  cloudfront_default_cache_behavior_headers = [
    "Access-Control-Request-Headers",
    "Access-Control-Request-Method",
    "Authorization",
    "Host",
    "Origin",
  ]
  viewer_cert_minimum_protocol_version = "TLSv1.1_2016"
  cdn_secret_header = data.terraform_remote_state.infrastructure.outputs.traefik_cdn_secret.name
  cdn_secret_value = data.terraform_remote_state.infrastructure.outputs.traefik_cdn_secret.value
}

## Resources
## FIX ME : https://github.com/terraform-providers/terraform-provider-aws/issues/8531
## FIXED IN AWS Provider 3.0
resource "null_resource" "sanlist" {
  triggers = {
    sanlist = join("", concat([var.domain_name], var.aliases))
  }
}
resource "aws_acm_certificate" "cert" {
  provider                  = aws.us
  domain_name               = var.domain_name
  subject_alternative_names = concat([var.domain_name], var.aliases)
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [subject_alternative_names]
  }
  tags = {
    Name = var.domain_name
  }
}
resource "aws_acm_certificate_validation" "cert" {
  provider        = aws.us
  certificate_arn = aws_acm_certificate.cert.arn
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  aliases             = concat([var.domain_name], var.aliases)
  comment             = local.comment
  default_root_object = ""
  enabled             = local.enabled
  http_version        = local.http_version
  is_ipv6_enabled     = "true"
  price_class         = "PriceClass_100"
  retain_on_delete    = local.retain_on_delete
  wait_for_deployment = local.wait_for_deployment
  web_acl_id          = var.cloudfront_web_acl_id
  origin {
    domain_name = var.domain_name
    origin_id   = "default"
    origin_path = local.cloudfront_default_custom_origin_path
    custom_origin_config {
      http_port                = local.cloudfront_default_custom_origin_http_port
      https_port               = local.cloudfront_default_custom_origin_https_port
      origin_keepalive_timeout = local.cloudfront_default_custom_origin_keepalive_timeout
      origin_read_timeout      = local.cloudfront_default_custom_origin_read_timeout
      origin_protocol_policy   = local.cloudfront_default_custom_origin_protocol_policy
      origin_ssl_protocols     = local.cloudfront_default_custom_origin_ssl_protocols
    }
    custom_header {
      name = local.cdn_secret_header
      value = local.cdn_secret_value
    }
  }

  default_cache_behavior {
    allowed_methods        = local.cloudfront_default_cache_behavior_allowed_methods
    cached_methods         = local.cloudfront_default_cache_behavior_cached_methods
    target_origin_id       = local.cloudfront_default_cache_behavior_target_origin_id
    compress               = local.cloudfront_default_cache_behavior_compress
    viewer_protocol_policy = local.cloudfront_default_cache_behavior_viewer_protocol_policy
    min_ttl                = local.cloudfront_default_cache_behavior_min_ttl
    default_ttl            = local.cloudfront_default_cache_behavior_default_ttl
    max_ttl                = local.cloudfront_default_cache_behavior_max_ttl
    forwarded_values {
      query_string = local.cloudfront_default_cache_behavior_query_string
      cookies {
        forward           = local.cloudfront_default_cache_behavior_cookies_forward
        whitelisted_names = local.cloudfront_default_cache_behavior_cookies_whitelisted_names
      }
      headers = local.cloudfront_default_cache_behavior_headers
    }

  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate_validation.cert.certificate_arn
    minimum_protocol_version = local.viewer_cert_minimum_protocol_version
    ssl_support_method       = "sni-only"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
## Outputs
