locals {
  vpc_name = "prod-vpc"
  public_subnets = {
    "public-1a" = {
      cidr = "10.10.0.0/24",
      az   = "us-east-2a"
    },
    "public-1b" = {
      cidr = "10.10.2.0/24",
      az   = "us-east-2b"
    }
  }
  private_subnets = {
    "private-1a" = {
      az   = "us-east-2a",
      cidr = "10.10.3.0/24"
    },
    "private-2a" = {
      az   = "us-east-2b",
      cidr = "10.10.4.0/24"
    }
  }
  ecr_name = ["frontend", "service1", "service2"]
}
// virtual network with 2 public and 2 private subnets 

resource "aws_vpc" "production" {
  cidr_block         = "10.10.0.0/16"
  enable_dns_support = true
  tags = {
    Name = local.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets

  vpc_id            = aws_vpc.production.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id            = aws_vpc.production.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "prod-gw" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name = "${local.vpc_name}-igw"
  }
}

resource "aws_nat_gateway" "prod-nat-gw" {
  allocation_id = aws_eip.nat-gw-eip.id
  subnet_id     = aws_subnet.public_subnets["public-1a"].id
}

resource "aws_eip" "nat-gw-eip" {

  tags = {
    Name = "nat-gw-eip"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.prod-nat-gw.id
  }

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.production.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-gw.id
  }
}

resource "aws_route_table_association" "public-rt-association" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.public_subnets[each.key].id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private-rt-association" {
  for_each = local.private_subnets

  subnet_id      = aws_subnet.private_subnets[each.key].id
  route_table_id = aws_route_table.private-rt.id
}


resource "aws_ecr_repository" "production-registry" { 
  for_each = toset(local.ecr_name)
  name = each.key
  force_delete = true 

  tags = { 
    Name = each.key
  }
}

