resource "aws_instance" "webServer" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = "t2.micro"
  user_data                   = file("aws-user-data.sh")
  vpc_security_group_ids      = [aws_security_group.webserver_sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
}