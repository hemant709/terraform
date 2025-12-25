output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "Public IP address (if assigned)"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.this.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name (if assigned)"
  value       = aws_instance.this.public_dns
}

output "security_group_ids" {
  description = "List of security group ids attached to the instance"
  value       = aws_instance.this.vpc_security_group_ids
}

output "ami_used" {
  description = "The AMI id used for the instance"
  value       = local.effective_ami
}