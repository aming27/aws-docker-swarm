variable naming {
  description = "The naming module output"
  type        = object({ db_subnet_group = string, tags = map(string), location_name = string })
}

variable subnet-ids {
  description =  "A list of VPC subnet IDs."
}