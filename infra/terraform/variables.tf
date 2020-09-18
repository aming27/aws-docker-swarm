variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "key_name" {
    description = "The name of the Key Pair that can be used to SSH to each instance in the cluster"
}

# variable "route53_zone_id" {
#     description = "The ID of the route 53 zone in which to create DNS entries"
# }

variable "domain" {
    description = "The root domain name (including subdomain) to use for DNS records"
}

variable "provisionersrc" {
    description = "The url of this repository"
    default = "docker-swarm-aws"
}

variable "instance_type" {
    description = "The instance types launched into the cluster"
}

variable "swarm_manager_count" {
    description = "The number of instances to run as swarm managers"
}

variable "volume_size" {
    description = "The disk size for each cluster instance"
}

variable "ssh_access" {
    description = "The source IP addresses allowed to SSH onto the cluster instances"
    
}

variable "database_password" {
  type        = string
  description = "Database password inside storage engine"
}

variable "environment" {
  description = "The environment"
  default = "development"
} 
