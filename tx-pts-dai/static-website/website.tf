locals {
  dns_domain = "dai.tx.group"
  sub_domain = "20240307-10"
}

# module "v0_2_0" {
#   source = "../../../../tx-pts-dai/terraform-aws-static-website"
#   providers = {
#     aws.us = aws.us
#   }

#   url                 = "${local.sub_domain}-v0-2-0.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

# module "fum_versioning_null" {
#   source = "../../../../tx-pts-dai/terraform-aws-static-website"
#   providers = {
#     aws.us = aws.us
#   }

#   url                 = "${local.sub_domain}-null.${local.dns_domain}"
#   route53_domain      = local.dns_domain
#   static_content_path = "./static_files"

# }

module "fum_versioning_true" {
  source = "../../../../tx-pts-dai/terraform-aws-static-website"
  providers = {
    aws.us = aws.us
  }

  enable_bucket_versioning = true
  url                      = "${local.sub_domain}-true.${local.dns_domain}"
  route53_domain           = local.dns_domain
  static_content_path      = "./static_files"

}

module "fum_versioning_false" {
  source = "../../../../tx-pts-dai/terraform-aws-static-website"
  providers = {
    aws.us = aws.us
  }
  enable_bucket_versioning = false
  url                      = "${local.sub_domain}-false.${local.dns_domain}"
  route53_domain           = local.dns_domain
  static_content_path      = "./static_files"

}

# resource "aws_s3_object" "test" {
#   for_each = toset([
#   "t1", "t2"])

#   bucket       = module.public.s3_bucket_name
#   key          = "${each.key}/"
#   source       = "./static_files/index.html"
#   content_type = "text/html"
#   etag         = filemd5("./static_files/index.html")
# }
