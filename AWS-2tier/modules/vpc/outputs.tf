output "REGION" {
  value = var.region
}

output "PROJECT_NAME" {
  value = var.project_name
}

output "VPC_ID" {
  value = aws_vpc.vpc.id
}

output "PUB_SUB_1_A_ID" {
  value = aws_subnet.pub-sub-1a.id
}
output "PUB_SUB_2_B_ID" {
  value = aws_subnet.pub-sub-2b.id
}
output "PRI_SUB_3_A_ID" {
  value = aws_subnet.pri-sub-3a.id
}

output "PRI_SUB_4_B_ID" {
  value = aws_subnet.pri-sub-4b.id
}

output "PRI_SUB_5_A_ID" {
  value = aws_subnet.pri-sub-5a.id
}

output "PRI_SUB_6_B_ID" {
    value = aws_subnet.pri-sub-6b.id
}

output "IGW_ID" {
    value = aws_internet_gateway.internet_gateway
}