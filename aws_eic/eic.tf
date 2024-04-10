resource "aws_ec2_instance_connect_endpoint" "this" {
  subnet_id          = local.private_subnets[0]
  security_group_ids = [aws_security_group.eic.id]
}

resource "aws_security_group" "eic" {
  name        = "${local.name}-eic"
  description = "for the eic endpoint"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "all_ipv4" {
  security_group_id = aws_security_group.eic.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv4" {
  security_group_id = aws_security_group.eic.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}
