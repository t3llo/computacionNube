terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_security_group" "webServerSG" {
  name        = "sg"
  description = "Allow incoming connections"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow HTTP connections"
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

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
resource "aws_instance" "webServer" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  user_data              = file("aws-user-data.sh")
  vpc_security_group_ids = [aws_security_group.webServerSG.id]
}