locals {
  pool_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.pool_name }, var.tags)
}

resource "aws_cognito_user_pool" "this" {
  name = local.pool_name

  auto_verified_attributes = var.auto_verified_attributes

  password_policy {
    minimum_length = var.password_policy["minimum_length"]
    require_uppercase = var.password_policy["require_uppercase"]
    require_lowercase = var.password_policy["require_lowercase"]
    require_numbers = var.password_policy["require_numbers"]
    require_symbols = var.password_policy["require_symbols"]
  }

  tags = local.default_tags
}

resource "aws_cognito_user_pool_client" "this" {
  name         = "${local.pool_name}-client"
  user_pool_id = aws_cognito_user_pool.this.id
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
}

resource "aws_cognito_identity_pool" "this" {
  count = var.create_identity_pool ? 1 : 0

  identity_pool_name               = local.pool_name
  allow_unauthenticated_identities = false

  cognito_identity_providers {
    client_id = aws_cognito_user_pool_client.this.id
    provider_name = aws_cognito_user_pool.this.endpoint
    server_side_token_check = false
  }
}
