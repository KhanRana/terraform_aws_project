#configuring a vpc
# is in eu-west-2 region
# Have 3 Availability Zones
# Have a Public subnet in each AZ
# Have a Private subnet in each AZ
# Have an Internet Gateway
# A route table that can deal with local traffic as well as route to the IGW for any other traffic

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "portfolio-vpc"
  }
}

