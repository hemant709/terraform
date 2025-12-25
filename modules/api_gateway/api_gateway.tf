locals {
  api_name = "${var.name}-${replace(uuid(), "-", "")[0:6]}"
  default_tags = merge({ "Name" = local.api_name }, var.tags)
}

resource "aws_apigatewayv2_api" "this" {
  name          = local.api_name
  protocol_type = var.protocol_type

  dynamic "cors_configuration" {
    for_each = length(keys(var.cors)) > 0 ? [var.cors] : []
    content {
      allow_credentials = try(cors_configuration.value["allow_credentials"], false)
      allow_headers     = try(cors_configuration.value["allow_headers"], [])
      allow_methods     = try(cors_configuration.value["allow_methods"], [])
      allow_origins     = try(cors_configuration.value["allow_origins"], [])
      expose_headers    = try(cors_configuration.value["expose_headers"], [])
      max_age           = try(cors_configuration.value["max_age"], null)
    }
  }

  tags = local.default_tags
}

resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.stage_name
  auto_deploy = true
}

resource "aws_apigatewayv2_route" "routes" {
  count = length(var.routes)
  api_id = aws_apigatewayv2_api.this.id
  route_key = var.routes[count.index]["route_key"]
  target    = try(var.routes[count.index]["target"], null)
}
