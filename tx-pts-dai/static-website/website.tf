locals {
  dns_domain = "dai.tx.group"
  sub_domain = "20240307-10"
}

module "public" {
  source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=fum-versioning"
  providers = {
    aws.us = aws.us
  }

  versioning          = "Enabled"
  url                 = "${local.sub_domain}.${local.dns_domain}"
  route53_domain      = local.dns_domain
  static_content_path = "./static_files"
}

# module "v0_2_0" {
#   source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=v0.2.0"
#   providers = {
#     aws.us = aws.us
#   }

#   url                 = "v0-${local.sub_domain}.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# module "fum_versioning_off" {
#   source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=fum-versioning"
#   providers = {
#     aws.us = aws.us
#   }

#   url                 = "no-ver-${local.sub_domain}.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# module "fum_versioning_enabled" {
#   source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=fum-versioning"
#   providers = {
#     aws.us = aws.us
#   }
#   versioning          = "Enabled"
#   url                 = "enabled-${local.sub_domain}.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# module "fum_versioning_disabled" {
#   source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=fum-versioning"
#   providers = {
#     aws.us = aws.us
#   }

#   versioning          = "Disabled"
#   url                 = "disabled-${local.sub_domain}.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# module "fum_versioning_suspended" {
#   source = "github.com/tx-pts-dai/terraform-aws-static-website.git?ref=fum-versioning"
#   providers = {
#     aws.us = aws.us
#   }

#   versioning          = "Suspended"
#   url                 = "suspended-${local.sub_domain}.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# resource "aws_s3_object" "test" {
#   for_each = toset([
#   "t1", "t2"])

#   bucket       = module.public.s3_bucket_name
#   key          = "${each.key}/"
#   source       = "./static_files/index.html"
#   content_type = "text/html"
#   etag         = filemd5("./static_files/index.html")
# }
