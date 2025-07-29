variable "name" {
  description = "Name for the resource"
  type        = string
  
  validation {
    condition     = length(var.name) > 0
    error_message = "Name cannot be empty."
  }
  
  validation {
    condition     = length(var.name) <= 20
    error_message = "Name must be 20 characters or less."
  }
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
