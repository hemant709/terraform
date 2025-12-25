// ECR module variables

variable "name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "ecr"
}

variable "image_tag_mutability" {
  description = "Tag mutability (MUTABLE or IMMUTABLE)"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for repository"
  type        = map(string)
  default     = {}
}

variable "lifecycle_policy" {
  description = "JSON lifecycle policy"
  type        = string
  default     = ""
}
