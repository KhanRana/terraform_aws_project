# create vpc
module "vpc" {
  source             = "./modules/vpc"
  vpc_name           = "portfolio-vpc"
  cidr_range         = "10.0.0.0/16"
  availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets    = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

# attach security groups 
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

# create instance and attach the security group
module "smart_home_server" {
  source          = "./modules/smart_home_server"
  subnet_ids       = module.vpc.public_subnets
  security_groups = [module.security.security_group_ids]
  key_pair        = "MyKeyPair"
  AMI = ["ami-08c766676481fd5aa", "ami-08aeb32d2c5d96e18", "ami-0bb05632bcd4998a5"]
  ec2_name        = ["smart_home_001", "smart_home_002", "smart_home_003"]
}

# dynamo data table
module "dynamo" {
  source = "./modules/dynamo"
 table_name = ["lighting", "heating"]
 attribute_name = "id"
 attribute_type = "N"
 billing_mode = "PROVISIONED"
 read_capacity= "30"
 write_capacity= "30"
 hash_key = "id"
}

# load balancer with three traget groups each containing individual instance

module "load_balancing" {
  source          = "./modules/load_balancer"
  vpc_id          = module.vpc.vpc_id
  ec2_id          = module.smart_home_server.instance_id
  security_groups = [module.security.security_group_ids]
  subnets         = module.vpc.public_subnets
  apps = ["lights", "heating", "status"]
}

# Create autoscaling groups one instance available in each region 
module "autoscaling" {
  count = length(module.load_balancing.lb-tg-arn)
  source = "./modules/autoscaling"
  AMI = var.AMI
  min_size = 1
  max_size = 3
  desired_capacity = 1
  security_groups = module.security.security_group_ids
  public_subnets = module.vpc.public_subnets
  instance_type = "t2.micro"
  lb-tg-arn = module.load_balancing.lb-tg-arn[count.index]
}