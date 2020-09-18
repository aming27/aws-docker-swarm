# Common resources
output "environment" {value = local.environment}
output "base_name" {value = local.base_name}
output "location_name" {value = local.location_name}
output "location_shortname" {value = local.location_shortname}

# Modules list
output "networking" {value = local.networking}
output "autoscaling-group" {value = local.autoscaling-group}
output "bucket" {value = local.bucket}
output "db_subnet_group" {value = local.db_subnet_group}
output "application_load_balancer" {value = local.application_load_balancer}
output "target_group" { value = local.target_group }
output "ecr_repository" { value = local.ecr_repository }

# Tags
output "tags" {value = local.tags}

