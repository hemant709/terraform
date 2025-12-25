locals {
  repo_name = var.name != "" ? var.name : "repo-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.repo_name }, var.tags)
}

resource "aws_ecr_repository" "this" {
  name                 = local.repo_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = local.default_tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count = var.lifecycle_policy != "" ? 1 : 0
  repository = aws_ecr_repository.this.name
  policy     = var.lifecycle_policy
}
