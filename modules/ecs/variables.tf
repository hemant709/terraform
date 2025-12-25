// ECS module variables

variable "name" {
  description = "Name prefix for ECS resources"
  type        = string
  default     = "ecs"
}

variable "create_cluster" {
  description = "Whether to create an ECS cluster"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "Name of the cluster (if creating)"
  type        = string
  default     = ""
}

variable "enable_fargate" {
  description = "Whether to use Fargate for task/service"
  type        = bool
  default     = true
}

variable "task_memory" {
  description = "Task memory for Fargate tasks"
  type        = string
  default     = "512"
}

variable "task_cpu" {
  description = "Task cpu for Fargate tasks"
  type        = string
  default     = "256"
}

variable "container_definitions" {
  description = "JSON container definitions for task definition (optional)"
  type        = string
  default     = ""
}

variable "desired_count" {
  description = "If service is created, desired count"
  type        = number
  default     = 0
}

variable "subnet_ids" {
  description = "If creating service, subnet ids for ENI"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "Security groups for the service ENI"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
