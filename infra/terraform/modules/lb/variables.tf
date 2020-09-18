variable naming {
  description = "The naming module output"
  type        = object({ target_group = string, application_load_balancer = string, tags = map(string) })
}

variable s3-id {
  description = "The name of the bucket."
  type        = string
}
variable "subnet-ids" {
  description = "ids public subnets"
}
variable "vpc-id" {
  type        = string
  description = "ID of VPC meant to house database"
}
variable "target_type" {
  description = "The type of target that you must specify when registering targets with this target group"
  default = "instance"
}
variable "deregistration_delay" {
  description = "The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused."
  default     = 300
}

variable "health_check_interval" {
  description = "The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds."
  default     = 30
}

variable "health_check" {
  default = { 
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
 } 
}

variable "stickiness" {
  default = { 
    cookie_duration    = 86400
    enabled            = true
    
 } 
}
