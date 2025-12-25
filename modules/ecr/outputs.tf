output "repository_url" {
  description = "Repository URL"
  value       = aws_ecr_repository.this.repository_url
}

output "repository_id" {
  description = "Repository ID"
  value       = aws_ecr_repository.this.id
}