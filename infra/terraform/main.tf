

module "naming" {
  source                 = "./modules/naming/"

  product_name           = local.product_name
  environment            = var.environment
  location               = local.location
  squad                  = local.squad
  chapter                = local.chapter
  product_version        = local.product_version
  
}


module "ami" {
  source = "./modules/ami/"
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = module.naming.networking

  cidr = "10.1.0.0/16"

  azs             = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.11.0/24", "10.1.12.0/24"]

  enable_nat_gateway = true

  tags = module.naming.tags 
}



module "bucket" {
  source = "./modules/s3"

  force_destroy = true
  naming        = module.naming
  #bucket        = module.naming.bucket
  
}

module "alb" {
  source = "./modules/lb"
  
  naming        = module.naming
  vpc-id        = module.vpc.vpc_id
  subnet-ids    = module.vpc.public_subnets
  s3-id         = module.bucket.bucket

}





module "manager" {
  source             = "./modules/autoscaling-group"
  
  naming             = module.naming
  ami-id             = module.ami.image_id
  key-name           = var.key_name
  size               = 1
  volume_size        = var.volume_size
  instance-type      = var.instance_type
  ssh_access         = var.ssh_access
  subnet-ids         = module.vpc.public_subnets
  vpc-id             = module.vpc.vpc_id

  role               = "manager"
  discovery-bucket   = module.bucket.bucket
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_manager" {
  autoscaling_group_name = module.manager.autoscaling-group-name
  elb                    = module.alb.id_alb
}

module "workers" {
  source             = "./modules/autoscaling-group"
  
  naming             = module.naming
  ami-id             = module.ami.image_id
  key-name           = var.key_name
  size               = 2
  volume_size        = var.volume_size
  instance-type      = var.instance_type
  ssh_access         = var.ssh_access
  subnet-ids         = module.vpc.public_subnets
  vpc-id             = module.vpc.vpc_id

  role               = "workers"
  discovery-bucket   = module.bucket.bucket
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_workers" {
  autoscaling_group_name = module.workers.autoscaling-group-name
  elb                    = module.alb.id_alb
}



module "db_subnet_group" {
  source     = "./modules/db_subnet_group"
  
  naming     = module.naming 
  subnet-ids = module.vpc.private_subnets[0]
}


module "rds" {
  source              = "./modules/rds-postgres"

  naming             = module.naming
  database_identifier = "rutyzntnych"
  database_name       = "my-db"
  database_username   = "my-username"
  database_password   = var.database_password
  vpc-id              = module.vpc.vpc_id
  cidr-block          = module.vpc.vpc_cidr_block
  subnet_group        = module.db_subnet_group.id_db_subnet_group
  
}



module "ecr" {
  source              = "./modules/ecr"

  naming             = module.naming
  
  
}



