locals {
  ecs_cluster_name         = "rba_ecs"
  ecs_task_definition_name = "rba_tdn"
  ecs_service_name         = "rba_sn"
  cpu                      = "256"
  memory                   = "512"
}
resource "aws_ecs_cluster" "this" {
  name               = local.ecs_cluster_name
  capacity_providers = ["FARGATE"]
}
