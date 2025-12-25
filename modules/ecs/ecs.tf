locals {
  name_prefix = var.cluster_name != "" ? var.cluster_name : "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.name_prefix }, var.tags)
}

resource "aws_ecs_cluster" "this" {
  count = var.create_cluster ? 1 : 0
  name  = local.name_prefix

  tags = local.default_tags
}

resource "aws_iam_role" "task_execution" {
  name = "${local.name_prefix}-ecs-exec-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "task_execution_attach" {
  role       = aws_iam_role.task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_cloudwatch_log_group" "task" {
  name = "/ecs/${local.name_prefix}"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "this" {
  count = var.container_definitions != "" ? 1 : 0

  family                   = local.name_prefix
  requires_compatibilities = var.enable_fargate ? ["FARGATE"] : ["EC2"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  network_mode             = var.enable_fargate ? "awsvpc" : "bridge"
  execution_role_arn       = aws_iam_role.task_execution.arn
  task_role_arn            = aws_iam_role.task_execution.arn
  container_definitions    = var.container_definitions
}

resource "aws_ecs_service" "this" {
  count = var.desired_count > 0 && var.container_definitions != "" ? 1 : 0

  name            = local.name_prefix
  cluster         = var.create_cluster ? aws_ecs_cluster.this[0].id : null
  task_definition = aws_ecs_task_definition.this[0].arn
  desired_count   = var.desired_count
  launch_type     = var.enable_fargate ? "FARGATE" : "EC2"

  network_configuration {
    subnets         = var.subnet_ids
    security_groups = var.security_groups
    assign_public_ip = true
  }

  tags = local.default_tags
}
