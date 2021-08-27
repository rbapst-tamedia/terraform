cloudfront_aliases = [
  "dummy.r0l1.ch",
  "*.dummy.r0l1.ch"
]

cloudfront_default_cache_behaviour = {
  path_pattern              = "*"
  allowed_methods           = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
  cached_methods            = ["GET", "HEAD", "OPTIONS"]
  target_origin_id          = "default"
  compress                  = true
  query_string              = true
  query_string_cache_keys   = []
  cookies_forward           = "all"
  cookies_whitelisted_names = []
  headers = [
    "Access-Control-Request-Headers",
    "Access-Control-Request-Method",
    "Authorization",
    "Host",
    "Origin",
  ]
  viewer_protocol_policy = "redirect-to-https"
  min_ttl                = 0
  default_ttl            = 0
  max_ttl                = 31536000 # 1 year
}

cloudfront_ordered_cache_behaviour = [
  {
    path_pattern              = "/_next/static/*"
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    target_origin_id          = "default"
    compress                  = true
    query_string              = false
    query_string_cache_keys   = []
    cookies_forward           = "none"
    cookies_whitelisted_names = []
    headers                   = ["Host", "Authorization", "Origin"]
    viewer_protocol_policy    = "redirect-to-https"
    min_ttl                   = 0
    default_ttl               = 31536000 # 1 year
    max_ttl                   = 31536000 # 1 year
  },
  {
    path_pattern              = "/"
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    target_origin_id          = "default"
    compress                  = true
    query_string              = false
    query_string_cache_keys   = []
    cookies_forward           = "none"
    cookies_whitelisted_names = []
    headers                   = ["Host", "Authorization", "Origin"]
    viewer_protocol_policy    = "redirect-to-https"
    min_ttl                   = 0
    default_ttl               = 0
    max_ttl                   = 31536000 # 1 year
  },
  {
    path_pattern              = "/querynull"
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    target_origin_id          = "default"
    compress                  = true
    query_string              = true
    query_string_cache_keys   = []
    cookies_forward           = "whitelist"
    cookies_whitelisted_names = ["dummy.r0l1.ch"]
    headers                   = ["Host", "Authorization", "Origin"]
    viewer_protocol_policy    = "redirect-to-https"
    min_ttl                   = 0
    default_ttl               = 0
    max_ttl                   = 31536000 # 1 year
  },
  {
    path_pattern              = "/querywhite"
    allowed_methods           = ["GET", "HEAD"]
    cached_methods            = ["GET", "HEAD"]
    target_origin_id          = "default"
    compress                  = true
    query_string              = true
    query_string_cache_keys   = ["page", "page2"]
    cookies_forward           = "none"
    cookies_whitelisted_names = []
    headers                   = ["Host", "Authorization", "Origin"]
    viewer_protocol_policy    = "redirect-to-https"
    min_ttl                   = 0
    default_ttl               = 0
    max_ttl                   = 31536000 # 1 year
  }
]

cloudfront_default_root_object = ""
cloudfront_web_acl_id          = ""
