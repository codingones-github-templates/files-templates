resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(local.tags, { "Name" = "${var.project}-vpc" })
}

# Get available zones for this account
data "aws_availability_zones" "available" {
  state = "available"
}

# Create subnets in the first two available availability zones
resource "aws_subnet" "public_1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.0.0/24"
  tags                    = merge(local.tags, { "Name" = "public_1", "visibility" = "public" })
}

resource "aws_subnet" "private_1" {
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.1.0/24"
  tags                    = merge(local.tags, { "Name" = "private_1", "visibility" = "private" })
}

resource "aws_subnet" "public_2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.2.0/24"
  tags                    = merge(local.tags, { "Name" = "public_2", "visibility" = "public" })
}

resource "aws_subnet" "private_2" {
  availability_zone       = data.aws_availability_zones.available.names[1]
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = false
  cidr_block              = "10.0.3.0/24"
  tags                    = merge(local.tags, { "Name" = "private_2", "visibility" = "private" })
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = local.tags
}

# Create route-tables
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = local.tags
}

# Associate table with public subnet
resource "aws_route_table_association" "public_1_route_association" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_2_route_association" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_route_table.id
}