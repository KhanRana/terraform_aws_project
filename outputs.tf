# VPC ID
output "vpc" {
  value = module.vpc.vpc_id
}

# Public subnets

output "public_subnets" {
  value = module.vpc.public_subnets
}

# EC2 Instances Names
output "ec2_instances" {
  value = module.smart_home_server.ec2_names
}

# Dynamo Tables
output "dynamo_tables" {
  value = module.dynamo.table_name
  sensitive = true
}

