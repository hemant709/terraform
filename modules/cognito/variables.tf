// Cognito module variables

variable "name" {
  description = "Name prefix for Cognito resources"
  type        = string
  default     = "cognito"
}

variable "auto_verified_attributes" {
  description = "Attributes to auto-verify"
  type        = list(string)
  default     = ["email"]
}

variable "password_policy" {
  description = "Password policy (map)"
  type = map(any)
  default = { minimum_length = 8, require_uppercase = false, require_lowercase = false, require_numbers = false, require_symbols = false }
}

variable "create_identity_pool" {
  description = "Whether to create an identity pool"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
