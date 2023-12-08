#configuring a vpc
# is in eu-west-2 region
# Have 3 Availability Zones
# Have a Public subnet in each AZ
# Have a Private subnet in each AZ
# Have an Internet Gateway
# A route table that can deal with local traffic as well as route to the IGW for any other traffic

resource "aws_vpc" "main" {
  cidr_block = var.cidr_range

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

# create public subnets

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name      = format("${var.vpc_name}-public-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

# create private subnets
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name      = format("${var.vpc_name}-private-%s", element(var.availability_zones, count.index))
    ManagedBy = "Terraform"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}


# public routes
resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name      = "${var.vpc_name}-public"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
