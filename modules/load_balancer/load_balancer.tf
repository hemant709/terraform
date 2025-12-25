locals {
  name_prefix = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.name_prefix }, var.tags)
}

resource "aws_lb" "this" {
  name               = local.name_prefix
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnet_ids

  tags = local.default_tags
}

resource "aws_lb_target_group" "this" {
  name     = local.name_prefix
  port     = var.listener_port
  protocol = "HTTP"
  vpc_id   = element(var.subnet_ids, 0) != "" ? null : null
  target_type = var.target_type

  health_check {
    path                = var.health_check["path"]
    interval            = var.health_check["interval"]
    timeout             = var.health_check["timeout"]
    unhealthy_threshold = var.health_check["unhealthy_threshold"]
    healthy_threshold   = var.health_check["healthy_threshold"]
  }

  tags = local.default_tags
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
