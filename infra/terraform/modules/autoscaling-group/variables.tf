variable naming {
  description = "The naming module output"
  type        = object({ autoscaling-group = string, tags = map(string), location_name = string })
}
// Settings
variable "vpc-id" {}
variable "ami-id" {}
variable "key-name" {}
variable "instance-type" {}
variable "subnet-ids" {}


// Instance Settings
variable "size" {
  default = 1
}
variable "volume_size" {
  default = 52
}

variable "user-data-vars" {
  type = map
  default = {
    foo = "bar"
  }
}
variable "discovery-bucket" {}
variable "role" {}
variable "ssh_access" {
    description = "The source IP addresses allowed to SSH onto the cluster instances"
    
}

