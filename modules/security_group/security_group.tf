locals {
  resource_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags  = merge({ "Name" = local.resource_name }, var.tags)
}

resource "aws_security_group" "this" {
  name   = local.resource_name
  vpc_id = var.vpc_id
  tags   = local.default_tags
}

resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = try(var.ingress_rules[count.index]["from_port"], 0)
  to_port           = try(var.ingress_rules[count.index]["to_port"], 0)
  protocol          = try(var.ingress_rules[count.index]["protocol"], "tcp")
  cidr_blocks       = try(var.ingress_rules[count.index]["cidr_blocks"], [])
  ipv6_cidr_blocks  = try(var.ingress_rules[count.index]["ipv6_cidr_blocks"], [])
  security_groups   = try(var.ingress_rules[count.index]["security_groups"], [])
  self              = try(var.ingress_rules[count.index]["self"], false)
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  from_port         = try(var.egress_rules[count.index]["from_port"], 0)
  to_port           = try(var.egress_rules[count.index]["to_port"], 0)
  protocol          = try(var.egress_rules[count.index]["protocol"], "-1")
  cidr_blocks       = try(var.egress_rules[count.index]["cidr_blocks"], ["0.0.0.0/0"])
  ipv6_cidr_blocks  = try(var.egress_rules[count.index]["ipv6_cidr_blocks"], [])
  security_groups   = try(var.egress_rules[count.index]["security_groups"], [])
  self              = try(var.egress_rules[count.index]["self"], false)
  security_group_id = aws_security_group.this.id
}
