resource "aws_lb" "this" {
  name_prefix        = "rba"
  load_balancer_type = "network"
  subnets            = local.public_subnets
}
resource "aws_lb_target_group" "port_443" {
  name_prefix = "rba"
  port        = 443
  protocol    = "TCP"
  vpc_id      = local.vpc_id
  target_type = "ip"
  health_check {
    enabled  = true
    port     = 80
    protocol = "TCP"
  }
}
resource "aws_lb_listener" "port_443" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port_443.arn
  }
}
resource "aws_lb_target_group" "port_80" {
  name_prefix = "rba"
  port        = 80
  protocol    = "TCP"
  vpc_id      = local.vpc_id
  target_type = "ip"
  health_check {
    enabled  = true
    port     = 80
    protocol = "TCP"
  }
}
resource "aws_lb_listener" "port_80" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.port_80.arn
  }
}
