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
  ec2_name        = ["smart_home_001", "smart_home_002", "smart_home_003"]
}

# dynamo data table
module "dynamo" {
  source = "./modules/dynamo"
 table_name = "lighting"
 attribute_name = "id"
 attribute_type = "N"
 billing_mode = "PROVISIONED"
 read_capacity= "30"
 write_capacity= "30"
 hash_key = "id"
}
