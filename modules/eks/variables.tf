// EKS module variables

variable "name" {
  description = "Cluster name prefix"
  type        = string
  default     = "eks"
}

variable "version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "subnet_ids" {
  description = "Subnets for EKS cluster"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups for EKS control plane"
  type        = list(string)
  default     = []
}

variable "node_group" {
  description = "Node group configuration (map)"
  type = object({
    name         = string
    instance_types = list(string)
    desired_size = number
    min_size     = number
    max_size     = number
  })
  default = {
    name = "ng-1"
    instance_types = ["t3.medium"]
    desired_size = 2
    min_size = 1
    max_size = 3
  }
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
