resource "aws_vpc" "inspire" {
  cidr_block           = "10.1.1.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "inspire-vpc"
  }
}

resource "aws_internet_gateway" "inspire" {
  vpc_id = aws_vpc.inspire.id

  tags = {
    Name = "inspire-igw"
  }
}

resource "aws_subnet" "inspire" {
  vpc_id                  = aws_vpc.inspire.id
  cidr_block              = "10.1.1.0/25"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "inspire-subnet"
  }
}

resource "aws_route_table" "inspire" {
  vpc_id = aws_vpc.inspire.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.inspire.id
  }

  tags = {
    Name = "inspire-rt"
  }
}

resource "aws_route_table_association" "inspire" {
  subnet_id      = aws_subnet.inspire.id
  route_table_id = aws_route_table.inspire.id
}