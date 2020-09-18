resource "aws_s3_bucket" "bucket" {
  bucket = "rba-test-livecycle-bucket"
  acl    = "private"
  tags = {
    "owner" = "roland bapst"
    "file"  = "https://github.com/rbapst-tamedia/terraform/s3.tf"
  }
  force_destroy = false

  lifecycle_rule {
    id      = "log"
    enabled = true
    prefix  = "3_days/"
    expiration {
      days = 3
    }
  }

  lifecycle_rule {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true
    expiration {
      days = 1
    }
  }
}
