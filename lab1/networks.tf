resource "aws_vpc" "MyLabVPC" {
  cidr_block = var.vpc_cidr_block

}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.MyLabVPC.id
  cidr_block = var.public_subnet_cidr
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
