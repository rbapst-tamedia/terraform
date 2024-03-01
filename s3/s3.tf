variable "fuw_exchange_bucket_prefix" {
  description = "Prefix of S3 bucket name to allow exchange of data between user and wordpress legacy fuw website. Set to empty to not create it. \"-AWS_ACCOUNT_ID\" will be append"
  type        = string
  default     = "test-rba"
}

locals {
  deploy_fuw_exchange_bucket = var.fuw_exchange_bucket_prefix != "" ? true : false
}

# S3 Bucket
module "fuw_exchange_bucket" {
  count = local.deploy_fuw_exchange_bucket ? 1 : 0

  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.1.0"

  # It's a POC, reason of the "-poc" at the end. Should be removed if it's accepted
  bucket = "${var.fuw_exchange_bucket_prefix}-${data.aws_caller_identity.current.account_id}-poc"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }
}
