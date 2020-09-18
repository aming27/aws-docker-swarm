variable naming {
  description = "The naming module output"
  type        = object({ bucket = string, tags = map(string), location_name = string })
}

variable "force_destroy" {
  default = false
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
}


