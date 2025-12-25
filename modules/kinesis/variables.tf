// Kinesis module variables

variable "name" {
  description = "Name prefix for the stream"
  type        = string
  default     = "kinesis"
}

variable "shard_count" {
  description = "Number of shards"
  type        = number
  default     = 1
}

variable "retention_period_hours" {
  description = "Retention period in hours"
  type        = number
  default     = 24
}

variable "encryption_type" {
  description = "Encryption type (NONE or KMS)"
  type        = string
  default     = "NONE"
}

variable "kms_key_id" {
  description = "Optional KMS key id to use when encryption_type = \"KMS\""
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
