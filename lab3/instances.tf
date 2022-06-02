
#Esta primera instancia es la que sera usada para crear la imagen para el Auto scaling group

resource "aws_instance" "webServer_1" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
    subnet_id = aws_subnet.private_subnet_1a.id
    vpc_security_group_ids = [ aws_security_group.bastion_security_group.id ]
    key_name = aws_key_pair.kp.key_name
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
