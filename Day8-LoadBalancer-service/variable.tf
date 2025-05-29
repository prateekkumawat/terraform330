variable "orgnization" {}
variable "enviornment" {}
variable "vpc_cidr_block" {}
variable "subnet_cidr" {
  type = list
}
variable "az" {
  type = list
}
variable "aws_region" {}
variable "dbinstance_subnet_group_name" {}
variable "aws_ami_image" {}
variable "aws_instnace_type" {}