data "aws_iam_policy_document" "assume_ecs_tasks_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "task" {
  name               = "rba_ecs_task_role"
  assume_role_policy = data.aws_iam_policy_document.assume_ecs_tasks_role.json
}
resource "aws_iam_role_policy_attachment" "task" {
  role       = aws_iam_role.task.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
resource "aws_ecs_task_definition" "this" {
  family                   = local.ecs_task_definition_name
  container_definitions    = file("task_definition.json")
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  #  task_role_arn            = aws_iam_role.task.arn
  execution_role_arn = aws_iam_role.task.arn
  cpu                = local.cpu
  memory             = local.memory
}
resource "aws_ecs_service" "this" {
  count           = 1
  name            = local.ecs_service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = local.public_subnets
    assign_public_ip = true
  }
  # load_balancer {
  #   target_group_arn = aws_lb_target_group.port_80.arn
  #   container_name   = "nginxdemo"
  #   container_port   = 80
  # }
}
resource "aws_cloudwatch_log_group" "this" {
  name              = "/fargate/service/rba-logs"
  retention_in_days = 14
}
