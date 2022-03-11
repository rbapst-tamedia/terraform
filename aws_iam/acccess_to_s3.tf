locals {
  s3bucket_arn = "S3Bucket"
  subdir       = "/my/subdir"
}

#
# AWS IAM policy to allow access to part of an S3 bucket
#
resource "aws_iam_policy" "this" {
  name        = "S3-subdir-full-access"
  path        = "/"
  description = "To have full access on the  part of an S3 bucket"

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect" = "Allow",
        "Action" = [
          "s3:GetBucketLocation",
          "s3:ListAllMyBuckets"
        ],
        "Resource" = "*"
      },
      {
        "Effect"    = "Allow",
        "Action"    = ["s3:*"],
        "Resource"  = "${local.s3bucket_arn}${subdir}/*",
        "Condition" = {}
      },
      {
        "Effect"    = "Allow",
        "Action"    = ["s3:ListBucket"],
        "Resource"  = "${local.s3bucket_arn}",
        "Condition" = {}
      }
    ]
  })
}

#
# Users which should have access to this part of the bucket
#
variable "users" {
  description = "List of users which should have full access to the ${local.s3bucket_arn}${local.subdir} bucket"
  type = list(object({
    username    = string
    email       = string
    description = string
  }))
  default = [
    {
      username    = "Roland_Bapst",
      email       = "roland.bapst@tx.group",
      description = "Just an example"
    }
  ]
}

#
# IAM user/access_key/secret for each user
#
resource "aws_iam_user_policy_attachment" "external_full_access" {
  for_each = aws_iam_user.bucket_full_access

  user       = each.value.name
  policy_arn = aws_iam_policy.external_full_access.arn
}

resource "aws_iam_user" "bucket_full_access" {
  for_each = { for user in var.users : user.username => user }

  name = each.value.username
  path = "/s3/${local.s3bucket_arn}/"
}

#
# Since here: Bad Practice because access key will be stored in terraform state
#
# Create a key for each user
resource "aws_iam_access_key" "bucket_full_access" {
  for_each = aws_iam_user.bucket_full_access

  user = each.value.name
}

# Create a secret for each key/user
resource "aws_secretsmanager_secret" "bucket_full_access" {
  for_each = aws_iam_access_key.bucket_full_access

  name = each.value.user
}

# Store each user key to a secret
resource "aws_secretsmanager_secret_version" "bucket_full_access" {
  for_each = aws_iam_access_key.bucket_full_access

  secret_id = aws_secretsmanager_secret.bucket_full_access[each.key].id
  secret_string = jsonencode({
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.bucket_full_access[each.key].id,
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.bucket_full_access[each.key].secret
  })
}

