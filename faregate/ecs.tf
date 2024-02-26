module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 4.0"

  cluster_name = "rba-test"

  cluster_settings = {
    "name" : "containerInsights",
    "value" : "enabled"
  }
}

locals {
  ecs_cluster_name         = "rba_ecs"
  ecs_task_definition_name = "rba_tdn"
  ecs_service_name         = "rba_sn"
  cpu                      = "256"
  memory                   = "512"
}
