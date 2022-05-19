terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.14.0"
    }
  }
}

provider "aws" {}

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
  #user_data              = file("aws-user-data.sh")
  vpc_security_group_ids = [aws_security_group.webSG.id]
  subnet_id = aws_subnet.public.id
  associate_public_ip_address =  true
}