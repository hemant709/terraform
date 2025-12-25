output "route_table_id" {
  description = "The ID of the route table"
  value       = aws_route_table.this.id
}

output "associations" {
  description = "IDs of associations created"
  value       = aws_route_table_association.assoc[*].id
}