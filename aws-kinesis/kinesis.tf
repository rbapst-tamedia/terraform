# Resources to allow forwarding of cloudfront real-time logs to datadog
# It's using Kinesis Stream and Firehose Stream
resource "aws_kinesis_stream" "cloudfront" {
  name             = "cloudfront-realtime-logs"
  retention_period = 24 # in hours (24=default)

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
}

resource "aws_kinesis_firehose_delivery_stream" "cloudfront" {
  name        = "cloudfront-realtime-logs"
  destination = "http_endpoint"

  kinesis_source_configuration {
    kinesis_stream_arn = aws_kinesis_stream.cloudfront.arn
    role_arn           = aws_iam_role.firehose.arn
  }

  http_endpoint_configuration {
    url                = "https://aws-kinesis-http-intake.logs.datadoghq.eu/v1/input"
    name               = "my test"
    role_arn           = aws_iam_role.firehose.arn
    buffering_size     = 4  # number (5=default)
    buffering_interval = 60 # in seconds (300=default)
    retry_duration     = 60 # in seconds (300=default)

    cloudwatch_logging_options {
      enabled         = true
      log_group_name  = aws_cloudwatch_log_group.this.name
      log_stream_name = aws_cloudwatch_log_stream.this.name
    }

    s3_configuration {
      role_arn            = aws_iam_role.firehose.arn
      bucket_arn          = data.aws_s3_bucket.this.arn
      prefix              = "rba-test-kinesis/"
      error_output_prefix = "rba-test-kinesis-error/"
    }

    request_configuration {
      content_encoding = "GZIP"
    }
  }
  depends_on = [
    aws_iam_role_policy_attachment.firehose
  ]
}

# For firehose stream logging
resource "aws_cloudwatch_log_group" "this" {
  name              = "rba-test-kinesis"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "DestinationDelivery"
  log_group_name = aws_cloudwatch_log_group.this.name
}

# Needed role/permission for firehose stream
resource "aws_iam_role" "firehose" {
  name               = "firehose_test_role"
  assume_role_policy = data.aws_iam_policy_document.firehose_assume_role.json
}

resource "aws_iam_role_policy_attachment" "firehose" {
  role       = aws_iam_role.firehose.name
  policy_arn = aws_iam_policy.firehose.arn
}

resource "aws_iam_policy" "firehose" {
  name        = "firehose_test_policy"
  description = "Permissions for {aws_kinesis_firehose_delivery_stream.cloudfront.name} firehose stream"
  policy      = data.aws_iam_policy_document.firehose_permissions.json
}

data "aws_iam_policy_document" "firehose_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["firehose.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "firehose_permissions" {
  statement {
    actions = [
      "glue:GetTable",
      "glue:GetTableVersion",
      "glue:GetTableVersions"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:glue:eu-central-1:${data.aws_caller_identity.current.account_id}:catalog"
    ]
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    effect = "Allow"
    resources = [
      data.aws_s3_bucket.this.arn,
      "${data.aws_s3_bucket.this.arn}/*",
    ]
  }

  statement {
    actions = [
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = [
      aws_cloudwatch_log_group.this.arn,
    ]
  }
  statement {
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
      "kinesis:ListShards"
    ]
    effect = "Allow"
    resources = [
      aws_kinesis_stream.cloudfront.arn
    ]
  }
}

#
data "aws_s3_bucket" "this" {
  bucket = "terraform-20230928100113498400000003"
}
