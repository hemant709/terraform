locals {
  stream_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.stream_name }, var.tags)
}

resource "aws_kinesis_stream" "this" {
  name             = local.stream_name
  shard_count      = var.shard_count
  retention_period = var.retention_period_hours

  tags = local.default_tags

  dynamic "server_side_encryption" {
    for_each = var.encryption_type == "KMS" ? [1] : []
    content {
      enabled   = true
      kms_key_id = var.kms_key_id != "" ? var.kms_key_id : null
    }
  }
}
