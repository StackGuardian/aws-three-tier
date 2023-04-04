# Creating VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name       = "${var.project_name}-${var.env}-vpc"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#Public subent. Three public subnets in each az will be created. 
resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidrs)
  cidr_block              = element(var.public_subnets_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name       = "${var.project_name} ${var.env} public-subnet ${count.index + 1}"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#Private subent. Three private subnets in each az will be created. 
resource "aws_subnet" "private-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnets_cidrs)
  cidr_block              = element(var.private_subnets_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name       = "${var.project_name} ${var.env} private-subnet ${count.index + 1}"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#Internet gateway will be created. 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  depends_on = [
    aws_vpc.vpc
  ]
  tags = {
    Name       = "${var.project_name}-${var.env}-igw"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#Route table for public subnets
resource "aws_route_table" "public-routetable" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name       = "${var.project_name}-${var.env}-publicroutetable"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#Associating Public Subnets to the public-routetable
resource "aws_route_table_association" "public-subnet-asso" {
  count          = length(var.public_subnets_cidrs)
  subnet_id      = element(aws_subnet.public-subnet[*].id, count.index)
  route_table_id = aws_route_table.public-routetable.id
}

#DB Subnet group in PublicSubnet
resource "aws_db_subnet_group" "public-subnet-db" {
  name       = "${var.project_name}-${var.env}-public"
  subnet_ids = aws_subnet.public-subnet[*].id
  tags = {
    Name       = "${var.project_name}-${var.env} public db subnet"
    Project    = var.project_name
    Enviroment = var.env
  }
}

#DB Subnet group in PrivateSubnet
resource "aws_db_subnet_group" "private-subnet-db" {
  name       = "${var.project_name}-${var.env}-private"
  subnet_ids = aws_subnet.private-subnet[*].id
  tags = {
    Name       = "${var.project_name}-${var.env} private db subnet"
    Project    = var.project_name
    Enviroment = var.env
  }
}
