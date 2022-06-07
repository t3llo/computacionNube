resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.kp.id
  instance_type               = "t2.micro"
    vpc_security_group_ids = [ aws_security_group.docker_security_group.id ]
  tags = {
    Name = " WebServer- CMS"
  }
}