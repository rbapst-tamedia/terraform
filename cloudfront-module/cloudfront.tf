## Variables
variable "cloudfront_aliases" {
  description = "Prefix list of domain name for alias record"
  type        = list(string)
}

variable "cloudfront_http_version" {
  description = "The maximum HTTP version to support on the distribution. Allowed values are http1.1 and http2. The default is http2."
  default     = "http2"
  type        = string
}

variable "cloudfront_enable_distribution" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  default     = true
  type        = string
}

variable "cloudfront_default_cache_behaviour" {
  description = "The default cache behavior for this distribution (maximum one)."
  type = object({
    path_pattern              = string
    allowed_methods           = list(string)
    cached_methods            = list(string)
    target_origin_id          = string
    compress                  = bool
    query_string              = bool
    query_string_cache_keys   = list(string)
    cookies_forward           = string
    cookies_whitelisted_names = list(string)
    headers                   = list(string)
    viewer_protocol_policy    = string
    min_ttl                   = number
    default_ttl               = number
    max_ttl                   = number
  })
}

variable "cloudfront_ordered_cache_behaviour" {
  description = "The ordered cache behaviors list for the distributions."
  type = list(object({
    path_pattern              = string
    allowed_methods           = list(string)
    cached_methods            = list(string)
    target_origin_id          = string
    compress                  = bool
    query_string              = bool
    query_string_cache_keys   = list(string)
    cookies_forward           = string
    cookies_whitelisted_names = list(string)
    headers                   = list(string)
    viewer_protocol_policy    = string
    min_ttl                   = number
    default_ttl               = number
    max_ttl                   = number
  }))
  default = []
}

variable "cloudfront_custom_origins" {
  type        = list(map(string))
  description = "A list of maps which configure the cloudfront custom origins. A primary one is pre-defined."
  default     = []
}

variable "cloudfront_s3_origins" {
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

variable "cloudfront_default_custom_origin_path" {
  default     = ""
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin."
}

variable "cloudfront_default_custom_origin_http_port" {
  default     = 80
  description = "The HTTP port the custom origin listens on."
}

variable "cloudfront_default_custom_origin_https_port" {
  default     = 443
  description = "The HTTPS port the custom origin listens on."
}

variable "cloudfront_default_custom_origin_keepalive_timeout" {
  default     = 60
  description = "he Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60."
}

variable "cloudfront_default_custom_origin_read_timeout" {
  default     = 60
  description = "The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60."
}

variable "cloudfront_default_custom_origin_protocol_policy" {
  default     = "https-only"
  description = "The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer."
}

variable "cloudfront_default_custom_origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1.2"]
  description = "The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2."
}

variable "cloudfront_default_root_object" {
  description = "Default object that cloudfront returns on calls on the root, e.g. index.html"
  default     = "index.html"
}

variable "cloudfront_price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  default     = "PriceClass_100"
}

variable "cloudfront_custom_error_response" {
  description = "The list of custom errors and their TTLs."
  type = list(object({
    error_code         = number
    min_ttl            = number
    response_page_path = string
    response_code      = number
  }))
  default = []
}

variable "cloudfront_web_acl_id" {
  description = "Id of the web_acl to attach"
  default     = null
}

locals {
  custom_header = [ {"name": "myheader", "value": "0x5ece7" } ]
  domain_name = "dummy.r0l1.ch"
  s3_bucket_regional_domain_name = "dummy.r0l1.ch.s3.eu-central-1.amazonaws.com"
}

## Resources
module "cdn" {
  providers = {
    aws = aws.us
  }
  source              = "github.com/DND-IT/infra-terraform-module.git//cloudfront?ref=teci-608"
  dns_domain_names    = var.dns_domain_names
  aliases             = var.cloudfront_aliases
  http_version        = var.cloudfront_http_version
  default_root_object = var.cloudfront_default_root_object
  webacl              = var.cloudfront_web_acl_id

  dynamic_custom_origin_config = concat([
    {
      domain_name              = local.domain_name
      origin_id                = "default"
      origin_path              = var.cloudfront_default_custom_origin_path
      http_port                = var.cloudfront_default_custom_origin_http_port
      https_port               = var.cloudfront_default_custom_origin_https_port
      origin_keepalive_timeout = var.cloudfront_default_custom_origin_keepalive_timeout
      origin_read_timeout      = var.cloudfront_default_custom_origin_read_timeout
      origin_protocol_policy   = var.cloudfront_default_custom_origin_protocol_policy
      origin_ssl_protocols     = var.cloudfront_default_custom_origin_ssl_protocols
      custom_header            = local.custom_header
    }
    ],
    var.cloudfront_custom_origins
  )
  dynamic_s3_origin_config = concat([
    {
      domain_name            = aws_s3_bucket.web_assets.bucket_regional_domain_name
      origin_id              = "web-assets"
      origin_path            = ""
      origin_access_identity = aws_cloudfront_origin_access_identity.web_assets_access_identity.cloudfront_access_identity_path
    }
    ],
    var.cloudfront_s3_origins
  )
  enable_cloudfront                = var.cloudfront_enable_distribution
  default_cache_behavior           = var.cloudfront_default_cache_behaviour
  dynamic_origin_group             = var.cloudfront_origin_groups
  dynamic_ordered_cache_behavior   = var.cloudfront_ordered_cache_behaviour
  cloudfront_price_class           = var.cloudfront_price_class
  cloudfront_custom_error_response = var.cloudfront_custom_error_response
}

## Outputs
