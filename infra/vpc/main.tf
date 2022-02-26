
resource "aws_vpc" "tst-hth-vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.standard_tags, {
  })
}

resource "aws_internet_gateway" "tst-hth-igw" {
  vpc_id = aws_vpc.tst-hth-vpc.id

  tags = merge(local.standard_tags, {
  })
}

## public subnets with connection to the internet gateway
resource "aws_subnet" "tst-hth-public-subnet" {
  count = length(var.aws_azs)

  cidr_block              = cidrsubnet(aws_vpc.tst-hth-vpc.cidr_block, 8, count.index)
  vpc_id                  = aws_vpc.tst-hth-vpc.id
  availability_zone       = element(var.aws_azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env_name}-public-subnet-${count.index}"
  }
}

## Route table for all public subnets
resource "aws_route_table" "tst-hth-public-route-table" {
  vpc_id = aws_vpc.tst-hth-vpc.id

  tags = {
    Name = "${var.env_name}-public-route-table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tst-hth-igw.id
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  count = length(var.aws_azs)

  route_table_id = aws_route_table.tst-hth-public-route-table.id
  subnet_id      = element(aws_subnet.tst-hth-public-subnet.*.id, count.index)
}

