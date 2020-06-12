# Internet VPC
#resource "aws_vpc" "main" {
#  cidr_block           = "10.0.0.0/16"
#  instance_tenancy     = "default"
#  enable_dns_support   = "true"
#  enable_dns_hostnames = "true"
#  enable_classiclink   = "false"
#  tags = {
#    Name = "main"
#  }
#}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "main-public-3" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "main-public-3"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.7.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1b"

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = "vpc-4138e427"
  cidr_block              = "10.0.8.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "eu-west-1c"

  tags = {
    Name = "main-private-3"
  }
}

# Internet GW
#resource "aws_internet_gateway" "main-gw" {
#  vpc_id = "vpc-4138e427"
#
#  tags = {
#    Name = "main"
#  }
#}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = "vpc-4138e427"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-6a8c080d"
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = aws_subnet.main-public-3.id
  route_table_id = aws_route_table.main-public.id
}

