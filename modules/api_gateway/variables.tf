// API Gateway v2 (HTTP API) module variables

variable "name" {
  description = "Name prefix for API"
  type        = string
  default     = "api"
}

variable "protocol_type" {
  description = "Protocol type (HTTP or WEBSOCKET)"
  type        = string
  default     = "HTTP"
}

variable "cors" {
  description = "CORS configuration (map), keys: allow_origins, allow_methods, allow_headers"
  type        = map(any)
  default     = {}
}

variable "stage_name" {
  description = "Stage name"
  type        = string
  default     = "$default"
}

variable "routes" {
  description = "List of routes (map with route_key, target)" 
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
