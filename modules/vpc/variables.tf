
# VPC cidr
variable "cidr_range" {
  type    = string
}

# VPC name
variable "vpc_name" {
  type    = string
}

# zones
variable "availability_zones" {
  type    = list(string)
}

# public subnets
variable "public_subnets" {
  type    = list(string)
}

# private subnets
variable "private_subnets" {
  type    = list(string)
}

