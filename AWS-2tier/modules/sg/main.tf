resource "aws_security_group" "alb-sg" {
  name   = "alb security group"
  description = "enable http/https access on port 80/443"
  vpc_id = var.VPC_ID

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB_SG"
  }
}


resource "aws_security_group" "client-sg" {
  name   = "client security group"
  description = "enable http/https access on port 80/443 for alb sg"
  vpc_id = var.VPC_ID

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups =  [aws_security_group.alb-sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
        Name = "Client_SG"
    }
}

resource "aws_security_group" "database-sg" {
  name = "database-sg"
  description = "enable mysql access on port 3306 from client-sg"
  vpc_id = var.VPC_ID

  ingress {
    description = "mysql access"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [ aws_security_group.client-sg.id ]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Database-sg"
  }
}

resource "aws_security_group" "jump-sg" {
  name = "jump-sg"
  description = "Enable SSH access on port 22"
  vpc_id = var.VPC_ID

  ingress {
    description = "ssh access"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name= "jump-sg"
  }
}