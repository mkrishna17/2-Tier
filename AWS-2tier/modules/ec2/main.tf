resource "aws_instance" "jump_server" {
  ami           = var.ami
  instance_type = var.cpu
  subnet_id = var.PUB_SUB_1_A_ID
  vpc_security_group_ids = [var.jump_sg_id]
  key_name = var.Key_Name

  tags = {
    Name = "jump_server"
  }

}
  
  