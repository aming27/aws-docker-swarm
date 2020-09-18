variable product_name {
  description = "Product/Application name"
  type        = string
  default     = "product_name"
}

variable environment {
  description = "Deployment environment"
   type        = string
  default     = "dev"
 }

variable location {
  description = "Resource location"
  type        = string
  default     = "westeurope"
}

variable chapter {
  description = "CHAPTER owner"
  type        = string
  default     = "N/A"
}

variable squad {
  description = "Your squad"
  type        = string
  default     = "N/A"
}

variable product_version {
  description = "Product version (001, 002, ...)"
  type        = string
  default     = "001"
}

variable role {
  description = "ROLE docker swarm"
  type        = string
  default     = "N/A"
} 

