// Main resources for EC2 module

resource "aws_security_group" "this" {
  count = var.create_security_group && length(var.vpc_security_group_ids) == 0 ? 1 : 0

  name        = "${local.instance_name}-sg"
  description = "Security group for ${local.instance_name}"

  dynamic "ingress" {
    for_each = var.allow_ssh ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.ssh_cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.default_tags
}

resource "aws_instance" "this" {
  ami                    = local.effective_ami
  instance_type          = var.instance_type
  key_name               = var.key_name != "" ? var.key_name : null
  iam_instance_profile   = var.iam_instance_profile != "" ? var.iam_instance_profile : null
  disable_api_termination = var.disable_api_termination
  tenancy                = var.tenancy
  user_data              = var.user_data != "" ? var.user_data : null

  # Attach to provided security groups or to created one
  vpc_security_group_ids = length(var.vpc_security_group_ids) > 0 ? var.vpc_security_group_ids : (var.create_security_group ? [aws_security_group.this[0].id] : [])

  root_block_device {
    volume_size           = var.root_block_device.volume_size
    volume_type           = var.root_block_device.volume_type
    delete_on_termination = var.root_block_device.delete_on_termination
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.default_tags

  # If a subnet id is provided, set subnet_id
  subnet_id = var.subnet_id != "" ? var.subnet_id : null
}

// Optional additional EBS volumes
resource "aws_ebs_volume" "additional" {
  count             = length(var.ebs_block_devices)
  availability_zone = aws_instance.this.availability_zone

  size              = var.ebs_block_devices[count.index].volume_size
  type              = var.ebs_block_devices[count.index].volume_type

  tags = merge(local.default_tags, { "Name" = "${local.instance_name}-vol-${count.index}" })
}

resource "aws_volume_attachment" "additional_attach" {
  count       = length(var.ebs_block_devices)
  device_name = var.ebs_block_devices[count.index].device_name
  volume_id   = aws_ebs_volume.additional[count.index].id
  instance_id = aws_instance.this.id
  force_detach = true
}
