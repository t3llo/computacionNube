resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.nat_eip.id
}

resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
}

resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_route_table" "private_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}


resource "aws_route_table_association" "private_route_table_association" {
  route_table_id = aws_route_table.private_table.id
  subnet_id      = aws_subnet.private_subnet.id
}

resource "aws_subnet" "public_subnet" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidr
}

resource "aws_subnet" "private_subnet" {
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr
}
