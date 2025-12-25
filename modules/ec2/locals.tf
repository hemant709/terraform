locals {
  instance_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"

  default_tags = merge({
    "Name" = local.instance_name
  }, var.tags)

  // If user specified an AMI use that, otherwise use the looked up AMI
  effective_ami = var.ami != "" ? var.ami : data.aws_ami.selected.id
}