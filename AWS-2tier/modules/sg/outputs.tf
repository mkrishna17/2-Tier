output "ALB_SG_ID" {
    value = aws_security_group.alb-sg.id
  
}
output "CLIENT_SG_ID" {
  value = aws_security_group.client-sg.id
}
output "DB-SG-ID" {
  value = aws_security_group.database-sg.id
}
output "JUMP-SG-ID" {
  value = aws_security_group.jump-sg.id
}