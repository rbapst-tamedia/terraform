variable "website_bucket_name" {
  description = "Name of the S3 bucket to create"
  default     = "rba-20220311-1632"
}

variable "bucket_prefix" {
  description = "Prefix of S3 objects CloudFront can access"
  default     = ""
}

locals {
  deploy_logging = false
}

# Resources
resource "aws_s3_bucket" "website" {
  bucket = var.website_bucket_name
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  # Versioning disabled on S3 content is generated from githubd
  versioning {
    enabled = false
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPublicAccess",
        "Effect" : "Allow",
        "Principal" : {
        "AWS" : ["${aws_cloudfront_origin_access_identity.oai.iam_arn}"] },
        "Action" : ["s3:GetObject"],
        "Resource" : ["arn:aws:s3:::${var.website_bucket_name}${var.bucket_prefix}/*"]
      }
    ]
  })
}

# S3 bucket for logs (if enabled)
resource "aws_s3_bucket" "logs" {
  count = local.deploy_logging ? 1 : 0

  bucket = "cflogs-${var.website_bucket_name}"

  grant {
    id          = "c4c1ede66af53448b93c283ce9448c4ba468c9432aa01d700d3878632f77d2d0"
    permissions = ["FULL_CONTROL"]
    type        = "CanonicalUser"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning {
    enabled = false
  }
  lifecycle_rule {
    enabled = true
    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  count = local.deploy_logging ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPublicAccess",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : ["${aws_cloudfront_origin_access_identity.oai.iam_arn}"]
        },
        "Action" : ["s3:*"],
        "Resource" : [
          "${aws_s3_bucket.logs[0].arn}",
          "${aws_s3_bucket.logs[0].arn}/*"
        ]
      }
    ]
  })
}
