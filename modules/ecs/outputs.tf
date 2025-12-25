output "cluster_id" {
  description = "ECS Cluster ID"
  value       = try(aws_ecs_cluster.this[0].id, null)
}

output "task_definition_arn" {
  description = "Task definition ARN"
  value       = try(aws_ecs_task_definition.this[0].arn, null)
}

output "service_name" {
  description = "Service name (if created)"
  value       = try(aws_ecs_service.this[0].name, null)
}