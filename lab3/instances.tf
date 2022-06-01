resource "aws_instance" "webServer_1" {
  ami = "ami-01f18be4e32df20e2"
  instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet_1a.id
    vpc_security_group_ids = [ aws_security_group.bastion_security_group.id ]
    associate_public_ip_address = false
    tags = {
        Name = "Web CMS"
    }
}


#resource "aws_instance" "webServer_2" {
#  ami = "ami-01f18be4e32df20e2"
#  instance_type = "t2.micro"
#  subnet_id = aws_subnet.private_subnet_2a
#
#}
