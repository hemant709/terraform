locals {
  resource_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags  = merge({ "Name" = local.resource_name }, var.tags)
}