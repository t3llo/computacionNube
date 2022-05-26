resource "aws_instance" "DBwebServer" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.kp.key_name
  user_data                   = file("aws-user-data.sh")
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "webServer"
  }
}

resource "aws_instance" "mysqlserver" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.sqlserver_sg.id]
  subnet_id                   = aws_subnet.private_subnet.id
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = false
  tags = {
    Name = "MySQLServer"
  }
}