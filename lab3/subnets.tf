
#Aqui defino las subredes de la primera zona de disponibilidad

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.16.1.0/24"
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.16.2.0/24"
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1a"
  cidr_block        = "172.16.3.0/24"
}


#Aqui defino las subredes de la seguynda zona de disponibilidad

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "172.16.4.0/24"
}

resource "aws_subnet" "private_subnet_2a" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "172.16.5.0/24"
}

resource "aws_subnet" "private_subnet_2b" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "us-east-1b"
  cidr_block        = "172.16.6.0/24"
  
}

