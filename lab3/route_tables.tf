#Route table del igw

#Me di cuenta tarde de la confusion que puede causar mi esquema de nombres. La AZ 1 es la que contiene la subnet 1, 1a y 1b. La AZ 2 es subnet 2, 2a y 2b. 


resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet_1_to_igw" {
  route_table_id = aws_route_table.igw_route_table.id
  subnet_id = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_to_igw" {
  route_table_id = aws_route_table.igw_route_table.id
  subnet_id = aws_subnet.public_subnet_2.id

}


#route table de nat

resource "aws_route_table" "route_table_nat_1" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gateway1.id
  }
}

resource "aws_route_table" "route_table_nat_2" {
  vpc_id = aws_vpc.vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gateway2.id
  }
}

#asociar subnets a tabla de nat
resource "aws_route_table_association" "private_subnet_1a_to_nat" {
  route_table_id = aws_route_table.route_table_nat_1.id
  subnet_id = aws_subnet.private_subnet_1a.id
}

resource "aws_route_table_association" "private_subnet_1b_to_nat" {
  route_table_id = aws_route_table.route_table_nat_1.id
  subnet_id = aws_subnet.private_subnet_1b.id
}
resource "aws_route_table_association" "private_subnet_2a_to_nat" {
  route_table_id = aws_route_table.route_table_nat_2.id
  subnet_id = aws_subnet.private_subnet_2a.id
}
resource "aws_route_table_association" "private_subnet_2b_to_nat" {
  route_table_id = aws_route_table.route_table_nat_2.id
  subnet_id = aws_subnet.private_subnet_2b.id
}



