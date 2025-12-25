// Security Group module variables

variable "name" {
  description = "Name prefix for the security group"
  type        = string
  default     = "sg"
}

variable "vpc_id" {
  description = "VPC ID to create the security group in"
  type        = string
}

variable "ingress_rules" {
  description = "List of ingress rules (each a map: {from_port, to_port, protocol, cidr_blocks=[], security_groups=[]})"
  type        = list(map(any))
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules (same format as ingress)"
  type        = list(map(any))
  default     = []
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
