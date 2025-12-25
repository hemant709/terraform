// S3 module variables

variable "name" {
  description = "Name prefix for resources"
  type        = string
  default     = "s3"
}

variable "bucket_name" {
  description = "Optional explicit bucket name (leave empty for generated)"
  type        = string
  default     = ""
}

variable "acl" {
  description = "ACL for the bucket"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "block_public_acls" {
  description = "Block public ACLs"
  type        = bool
  default     = true
}

variable "server_side_encryption" {
  description = "Enable SSE (AES256 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules"
  type        = list(map(any))
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
