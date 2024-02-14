#Create elastic ip and this will be used for the nat-gateway in pub_sub_1a
resource "aws_eip" "EIP-NAT-A" {
    tags = {
        Name = "EIP-NAT-A"
  }
}

#Create elastic ip and this will be used for nat-gateway in pub_sub_2b

resource "aws_eip" "EIP-NAT-B" {
  tags = {
        Name = "EIP-NAT-B"
  }
}


#Create NAT Gateway in pub_sub_1a
resource "aws_nat_gateway" "NAT-GW-A" {
  allocation_id = aws_eip.EIP-NAT-A.id
  subnet_id     = var.PUB_SUB_1_A_ID

  tags = {
    Name = "NAT-GW-A"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.IGW_ID]
}

#Create NAT Gateway in pub_sub_2b
resource "aws_nat_gateway" "NAT-GW-B" {
  allocation_id = aws_eip.EIP-NAT-B.id
  subnet_id = var.PUB_SUB_2_B_ID
  
  tags = {
    Name = "NAT-GW-B"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.IGW_ID]
}


#create private route table PRI-RT-A and add route through NAT-GW-A
resource "aws_route_table" "PRI-RT-A"{
  vpc_id = var.VPC_ID

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GW-A.id
  }

  tags = {
    Name = "PRI-RT-A"
  }
}

#associate private subnet pri-sub-3a with private route table PRI-RT-A
resource "aws_route_table_association" "Pri-Sub3A-RTAssoc" {
  subnet_id         = var.PRI_SUB_3_A_ID
  route_table_id = aws_route_table.PRI-RT-A.id
}

# associate private subnet pri-sub-5-a with private route table Pri-RT-A
resource "aws_route_table_association" "Pri-Sub5A-RTAssoc" {
  subnet_id         = var.PRI_SUB_5_A_ID
  route_table_id    = aws_route_table.PRI-RT-A.id
}

# create private route table Pri-RT-B and add route through NAT-GW-B
resource "aws_route_table" "PRI-RT-B" {
  vpc_id            = var.VPC_ID

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.NAT-GW-B.id
  }

  tags   = {
    Name = "Pri-RT-B"
  }
}

# associate private subnet pri-sub-4-b with private route Pri-RT-B
resource "aws_route_table_association" "Pri-Sub4B-RTAsso" {
  subnet_id         = var.PRI_SUB_4_B_ID
  route_table_id    = aws_route_table.PRI-RT-B.id
}

# associate private subnet pri-sub-6-b with private route table Pri-RT-B
resource "aws_route_table_association" "Pri-Sub6B-RTAsso" {
  subnet_id         = var.PRI_SUB_6_B_ID
  route_table_id    = aws_route_table.PRI-RT-B.id
}