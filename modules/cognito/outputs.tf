output "user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.this.id
}

output "user_pool_client_id" {
  description = "User Pool Client ID"
  value       = aws_cognito_user_pool_client.this.id
}

output "identity_pool_id" {
  description = "Identity Pool ID (if created)"
  value       = try(aws_cognito_identity_pool.this[0].id, null)
}