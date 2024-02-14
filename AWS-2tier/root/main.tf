# creating VPC
module "vpc" {
    source = "../modules/vpc"
    region = var.region
    project_name= var.project_name
    vpc_cidr = var.vpc_cidr
    pub_sub_1a_cidr = var.pub_sub_1a_cidr
    pub_sub_2b_cidr = var.pub_sub_2b_cidr
    pri_sub_3a_cidr = var.pri_sub_3a_cidr
    pri_sub_4b_cidr = var.pri_sub_4b_cidr
    pri_sub_5a_cidr = var.pri_sub_5a_cidr
    pri_sub_6b_cidr = var.pri_sub_6b_cidr
}

module "nat" {
    source = "../modules/nat"
    VPC_ID = module.vpc.VPC_ID
    IGW_ID = module.vpc.IGW_ID
    PUB_SUB_1_A_ID = module.vpc.PUB_SUB_1_A_ID
    PUB_SUB_2_B_ID = module.vpc.PUB_SUB_2_B_ID
    PRI_SUB_3_A_ID = module.vpc.PRI_SUB_3_A_ID
    PRI_SUB_4_B_ID = module.vpc.PRI_SUB_4_B_ID
    PRI_SUB_5_A_ID = module.vpc.PRI_SUB_5_A_ID
    PRI_SUB_6_B_ID = module.vpc.PRI_SUB_6_B_ID
    }
    
module "sg" {
    source = "../modules/sg"
    VPC_ID = module.vpc.VPC_ID
}

module "key" {
  source = "../modules/key"
}

module "Server" {
  source = "../modules/ec2"
  jump_sg_id = module.sg.JUMP-SG-ID
  PUB_SUB_1_A_ID = module.vpc.PUB_SUB_1_A_ID
  Key_Name = module.key.KEY-NAME
}

module "alb" {
  source = "../modules/alb"
  project_name = module.vpc.PROJECT_NAME
  VPC_ID = module.vpc.VPC_ID
  PUB_SUB_1_A_ID = module.vpc.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID = module.vpc.PUB_SUB_2_B_ID
  ALB_SG = module.sg.ALB_SG_ID
}

module "cloudfront" {
  source = "../modules/cloudfront"
  project_name = module.vpc.PROJECT_NAME
  Certificate_Domain_Name = var.Certificate_Domain_Name
  ALB_Domain_Name = module.alb.ALB-DNS-NAME
  Additional_Domain_Name = var.Additional_Domain_Name
  
}

module "route-53" {
  source = "../modules/route-53"
  Cloudfront_Domain_Name = module.cloudfront.Cloudfront_Domain_Name
  Cloudfront_Hosted_Zone_ID = module.cloudfront.Cloudfront_Hosted_Zone_ID
}
