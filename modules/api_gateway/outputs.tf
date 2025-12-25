output "api_id" {
  description = "API Gateway id"
  value       = aws_apigatewayv2_api.this.id
}

output "api_endpoint" {
  description = "API endpoint"
  value       = aws_apigatewayv2_stage.this.invoke_url
}