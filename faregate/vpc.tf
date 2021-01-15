# Get Exported value from TX Group VPC service catalog
data "aws_cloudformation_export" "vpc" {
  name = "SC-VPC"
}
data "aws_cloudformation_export" "private_subnet_1" {
  name = "SC-VPC-PrivateSubnet1"
}
data "aws_cloudformation_export" "private_subnet_2" {
  name = "SC-VPC-PrivateSubnet2"
}
data "aws_cloudformation_export" "private_subnet_3" {
  name = "SC-VPC-PrivateSubnet3"
}
data "aws_cloudformation_export" "public_subnet_1" {
  name = "SC-VPC-PublicSubnet1"
}
data "aws_cloudformation_export" "public_subnet_2" {
  name = "SC-VPC-PublicSubnet2"
}
data "aws_cloudformation_export" "public_subnet_3" {
  name = "SC-VPC-PublicSubnet3"
}
locals {
  vpc_id = data.aws_cloudformation_export.vpc.value
  private_subnets = [
    data.aws_cloudformation_export.private_subnet_1.value,
    data.aws_cloudformation_export.private_subnet_2.value,
    data.aws_cloudformation_export.private_subnet_3.value
  ]
  public_subnets = [
    data.aws_cloudformation_export.public_subnet_1.value,
    data.aws_cloudformation_export.public_subnet_2.value,
    data.aws_cloudformation_export.public_subnet_3.value
  ]
}
