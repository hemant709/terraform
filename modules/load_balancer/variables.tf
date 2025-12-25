// Load Balancer module variables

variable "name" {
  description = "Name prefix"
  type        = string
  default     = "alb"
}

variable "subnet_ids" {
  description = "Subnets for the load balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups to attach to LB"
  type        = list(string)
  default     = []
}

variable "internal" {
  description = "Whether the LB is internal"
  type        = bool
  default     = false
}

variable "listener_port" {
  description = "Listener port"
  type        = number
  default     = 80
}

variable "target_type" {
  description = "Target group type: instance or ip"
  type        = string
  default     = "instance"
}

variable "health_check" {
  description = "Map of health check settings"
  type        = map(any)
  default     = { path = "/", interval = 30, timeout = 5, unhealthy_threshold = 2, healthy_threshold = 3 }
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
