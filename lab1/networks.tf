resource "aws_vpc" "MyLabVPC" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.MyLabVPC.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.MyLabVPC.id

}

resource "aws_eip" "nat_eip" {
  vpc = true
}
resource "aws_nat_gateway" "nat_gateway" {
  subnet_id = aws_subnet.public.id
  allocation_id = aws_eip.nat_eip.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.MyLabVPC.id
}
resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public.id
}

resource "aws_security_group" "vpc_security_group" {
  name = "VPC security group"
  description = "SG to allow traffic from the VPC"
  vpc_id = aws_vpc.MyLabVPC.id
  ingress {
    from_port = "0"
    to_port =  "0"
    protocol = "-1"
    self = true
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    self = true
  }
}

resource "aws_security_group" "webSG" {
  name        = "Web Security Group"
  description = "Enable HTTP access"
  vpc_id      = aws_vpc.MyLabVPC.id

  ingress {
    description = "Permit Web Requests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH connections"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
