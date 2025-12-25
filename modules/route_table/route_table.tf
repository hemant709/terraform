locals {
  resource_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags  = merge({ "Name" = local.resource_name }, var.tags)
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags   = local.default_tags
}

resource "aws_route" "custom" {
  count = length(var.routes)

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = try(var.routes[count.index]["destination_cidr_block"], null)
  gateway_id             = try(var.routes[count.index]["gateway_id"], null)
  nat_gateway_id         = try(var.routes[count.index]["nat_gateway_id"], null)
  network_interface_id   = try(var.routes[count.index]["network_interface_id"], null)
  instance_id            = try(var.routes[count.index]["instance_id"], null)
}

resource "aws_route_table_association" "assoc" {
  count = length(var.subnet_ids)

  subnet_id      = var.subnet_ids[count.index]
  route_table_id = aws_route_table.this.id
}
