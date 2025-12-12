deployment_env = production
cloudfront_ordered_cache_behaviour = [
  {
    path_pattern     = "/_next/static/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "web-assets"
    query_string     = false
    cookies_forward  = "none"
    headers = [
      "x-disco-waf-bypass",
    ]
    min_ttl                 = 31536000 # 1 year
    default_ttl             = 31536000 # 1 year
    realtime_log_config_arn = "arn:aws:cloudfront::883535314275:realtime-log-config/disco-redirects-issue"
  },
  {
    path_pattern     = "/_external/*"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "web-assets"
    query_string     = false
    cookies_forward  = "none"
    headers = [
      "x-disco-waf-bypass",
    ]
    min_ttl                 = 18000 # 5 hours
    default_ttl             = 18000 # 5 hours
    max_ttl                 = 18000 # 5 hours
    realtime_log_config_arn = null
  },
  {
    path_pattern     = "/disco-api/*"
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "application"
    query_string     = true
    cookies_forward  = "none"
    headers = [
      "Access-Control-Request-Headers",
      "Access-Control-Request-Method",
      "Authorization",
      "Origin",
      "Host",
      "x-disco-waf-bypass",
    ]
    realtime_log_config_arn = "ARN"
  },
  {
    path_pattern     = "/disco-api/*"
    allowed_methods  = ["HEAD", "DELETE", "POST", "GET", "OPTIONS", "PUT", "PATCH"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "application"
    query_string     = true
    cookies_forward  = "none"
    headers = [
      "Access-Control-Request-Headers",
      "Access-Control-Request-Method",
      "Authorization",
      "Origin",
      "Host",
      "x-disco-waf-bypass",
    ]
  }
]
