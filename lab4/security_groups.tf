resource "aws_security_group" "bastion_security_group" {
  vpc_id      = aws_vpc.vpc.id
  description = "Security group for Bastion Host"

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
  tags = {
    Name = "Bastion Security group"
  }
}

resource "aws_security_group" "mariadb_security_group" {
  vpc_id = aws_vpc.vpc.id
  description = "Security group for mariaDB server"
  ingress {
      description = "Allow DB connection"
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      security_groups = [ aws_security_group.webserver_security_group.id]
  }
  ingress {
    description = "SSH access from Bastion"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_security_group.id ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "MariaDB Security group"
  }

}

resource "aws_security_group" "webserver_security_group" {
  vpc_id = aws_vpc.vpc.id
  description = "Security group for webServers"

  ingress {
    description = "Allow SSH connections"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [ aws_security_group.bastion_security_group.id]
  } 

  ingress {
    description = "Allow HTTP Requests"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [ aws_security_group.load_balancer_security_group.id ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "WebServer Security Group"
  }
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = aws_vpc.vpc.id
  description = "Security group for Load Balancer"

  ingress {
    description = "Allow HTTP Requests"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}