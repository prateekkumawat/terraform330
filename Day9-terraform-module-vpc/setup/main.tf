module "vpc-account-1" {
  source = "../modules/vpc"
  vpc_details = var.vpc_details
  aws_region  = var.aws_region
  orgnization = var.orgnization
  enviornment = var.enviornment
  subnet_details = var.subnet_details
  igw_details = var.igw_details
}
