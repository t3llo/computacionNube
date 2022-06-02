resource "aws_instance" "db_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.mariadb_security_group.id]
  subnet_id                   = aws_subnet.private_subnet_1b.id
  key_name                    = aws_key_pair.kp.key_name
  associate_public_ip_address = false
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "MySQLServer"
  }
}