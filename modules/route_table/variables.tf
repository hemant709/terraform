// Route table module variables

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "route-table"
}

variable "vpc_id" {
  description = "VPC ID to create the route table in"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ids to associate with this route table"
  type        = list(string)
  default     = []
}

variable "routes" {
  description = "List of routes to create (each item a map: {destination_cidr_block, gateway_id, nat_gateway_id, network_interface_id, instance_id})"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
