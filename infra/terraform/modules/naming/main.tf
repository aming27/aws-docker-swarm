locals {
  location_names        = {
    "eu-west-1"      = "ew1"
    "eu-west-2"      = "ew2"
  }

  environments          = {
    "dev"            = "dev"
    "development"    = "dev"
    "int"            = "int"
    "integration"    = "int"
    "prd"            = "prd"
    "prdfc"          = "prd"
    "prdne"          = "prd"
    "prdus"          = "prd"
    "prduw"          = "prd"
    "prdwe"          = "prd"
    "prod"           = "prd"
    "prodfc"         = "prd"
    "prodne"         = "prd"
    "production"     = "prd"
    "produs"         = "prd"
    "produw"         = "prd"
    "prodwe"         = "prd"
    "qa"             = "qa"
    "staging"        = "stg"
    "stg"            = "stg"
    "test"           = "tst"
    "training"       = "trn"
    "trn"            = "trn"
    "tst"            = "tst"
    "uat"            = "uat"
  }

  # Common resources
  location_shortname    = local.location_names[lower(var.location)]
  location_name         = replace(lower(var.location), " ", "") # trimspace(lower(var.location)
  environment           = local.environments[lower(var.environment)]
  
  base_name             = "${var.product_name}-{resource}-${local.environment}-${local.location_shortname}-${var.product_version}"

  # Modules list
  networking                   = replace(local.base_name, "{resource}", "net")
  autoscaling-group            = replace(local.base_name, "{resource}", "asg")
  bucket                       = replace(local.base_name, "{resource}", "s3")
  db_subnet_group              = replace(local.base_name, "{resource}", "db_group")
  application_load_balancer    = replace(local.base_name, "{resource}", "alb")
  target_group                 = replace(local.base_name, "{resource}", "tg")
  ecr_repository               = replace(local.base_name, "{resource}", "ecr")
  
  # tags
  tags                  = {
    "Chapter"     = var.chapter
    "Environment" = local.environment
    "Product"     = var.product_name
    "Squad"       = var.squad
    "Version"     = var.product_version
    "Role"        = var.role
  }
}
