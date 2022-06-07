resource "aws_eip" "nat_eip1" {
  vpc = true
  tags = {
    Name = "NAT eip 1"
  }
}

resource "aws_eip" "nat_eip2" {
  vpc = true
  tags = {
    Name = "NAT eip 2"
  }
}

resource "aws_nat_gateway" "nat_gateway1" {
  allocation_id = aws_eip.nat_eip1.id
  subnet_id     = aws_subnet.public_subnet_1.id
  tags = {
    Name = "NAT 1"
  }
}

resource "aws_nat_gateway" "nat_gateway2" {
  allocation_id = aws_eip.nat_eip2.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "NAT 2"
  }
}