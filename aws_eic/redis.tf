resource "aws_elasticache_subnet_group" "this" {
  name       = local.name
  subnet_ids = local.private_subnets
}

resource "aws_elasticache_cluster" "this" {
  cluster_id           = local.name
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  engine_version       = "7.1"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_content.id]
  subnet_group_name    = aws_elasticache_subnet_group.this.name
}

resource "aws_security_group" "redis_content" {
  name        = "${local.name}-redis"
  description = "Allow Redis traffic"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "to_redis" {
  security_group_id            = aws_security_group.redis_content.id
  from_port                    = local.redis_port
  to_port                      = local.redis_port
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.eic.id
}
