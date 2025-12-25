locals {
  name_prefix = var.bucket_name != "" ? var.bucket_name : "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.name_prefix }, var.tags)
}

resource "aws_s3_bucket" "this" {
  bucket = local.name_prefix
  acl    = var.acl

  tags = local.default_tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls   = var.block_public_acls
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.server_side_encryption
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count  = length(var.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = var.lifecycle_rules
    content {
      id      = try(rule.value["id"], null)
      status  = try(rule.value["status"], "Enabled")

      dynamic "transition" {
        for_each = try(rule.value["transitions"], [])
        content {
          days          = transition.value["days"]
          storage_class = transition.value["storage_class"]
        }
      }

      expiration {
        days = try(rule.value["expiration_days"], null)
      }
    }
  }
}
