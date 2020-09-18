variable naming {
  description = "The naming module output"
  type        = object({ ecr_repository = string, tags = map(string), location_name = string })
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
}

# Timeouts
variable "timeouts" {
  description = "Timeouts map."
  type        = map
  default     = {}
}

variable "timeouts_delete" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = string
  default     = null
}


variable "policy" {
  description = "Manages the ECR repository policy"
  type        = string
  default     = null
}

variable "lifecycle_policy" {
  description = "Manages the ECR repository lifecycle policy"
  type        = string
  default     = null
}

