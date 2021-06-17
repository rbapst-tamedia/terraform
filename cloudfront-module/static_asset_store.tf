resource "aws_s3_bucket" "web_assets" {
  bucket = "dummy.r0l1.ch"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "_next_1_year"
    enabled = true
    prefix  = "_next/"
    expiration {
      days = 365
    }
  }
  lifecycle_rule {
    id      = "manifests_1_year"
    enabled = true
    prefix  = "manifests/"
    expiration {
      days = 365
    }
  }
}

resource "aws_cloudfront_origin_access_identity" "web_assets_access_identity" {
  comment = "Resource for the S3 origin"
}

resource "aws_s3_bucket_policy" "web_assets" {
  bucket = aws_s3_bucket.web_assets.id
  policy = data.aws_iam_policy_document.access_web_assets.json
}

data "aws_iam_policy_document" "access_web_assets" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.web_assets_access_identity.iam_arn]
    }
    resources = ["${aws_s3_bucket.web_assets.arn}/*"]
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.web_assets.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.web_assets_access_identity.iam_arn]
    }
  }
}
