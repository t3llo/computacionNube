#bastion para la primera AZ

resource "aws_instance" "bastion1" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_1.id
  key_name               = aws_key_pair.kp.key_name
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  associate_public_ip_address = true
  tags = {
    Name = "Bastion AZ 1"
  }
}

#Bastion para la segunda AZ

resource "aws_instance" "bastion2" {
    ami = data.aws_ami.amazon-linux-2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet_2.id
  key_name               = aws_key_pair.kp.key_name
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  associate_public_ip_address = true
  tags = {
    Name = "Bastion AZ 2"
  }
}