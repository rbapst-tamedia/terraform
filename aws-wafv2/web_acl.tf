#
# Test to deloy 2x AWS Web Acl:
# - one with one rule with "OR" statement for the 2 IP sets
# - one with two rules one per IP sets
# The "Web ACL rule capacity units used" is the same (2) the both versions
resource "aws_wafv2_web_acl" "one_rule" {
  provider    = aws.global
  description = "RBA TEST"
  name        = "rba-test-one-rule"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "allowed-list"
    priority = 2

    action {
      allow {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.allowed_ipv4.arn
          }
        }
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.allowed_ipv6.arn
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allowed-list"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "rba-test"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl" "two_rules" {
  provider    = aws.global
  description = "RBA TEST"
  name        = "rba-test-two-rules"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "allowed-list-ipv4"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.allowed_ipv4.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allowed-list-ipv4"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "allowed-list-ipv6"
    priority = 2

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.allowed_ipv6.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "allowed-list-ipv6"
      sampled_requests_enabled   = true
    }

  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "rba-test"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_ip_set" "allowed_ipv4" {
  provider           = aws.global
  name               = "allowed-ipv4"
  description        = "Google bot and event. other allowed ipv4 IPs"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses = [
    "127.0.0.1/32" # google bot
  ]
}

resource "aws_wafv2_ip_set" "allowed_ipv6" {
  provider           = aws.global
  name               = "allowed-ipv6"
  description        = "Google bot and event. other allowed ipv6 IPs"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV6"
  addresses = [
    "2001:4860:4801:10::/64" # google bot
  ]
}
