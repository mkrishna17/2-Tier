resource "aws_db_subnet_group" "website-subnet" {
  name = var.db_sub_name
  subnet_ids = [ var.PRI_SUB_5_A_ID, var.PRI_SUB_6_B_ID ]
}

resource "aws_db_instance" "website-db" {
  identifier = "website-db"
  engine = "mysql"
  engine_version = 5.7
  instance_class = "db.t2.micro"
  allocated_storage = 20
  username = var.db_username
  password = var.db_password
  db_name = var.db_name
  multi_az = true
  storage_type = "gp2"
  storage_encrypted = false 
  publicly_accessible = false
  backup_retention_period = 0
  vpc_security_group_ids =  [var.db_sg_id]
  db_subnet_group_name = aws_db_subnet_group.website-subnet.name

  tags = {
    Name = "website-db"
  }
}