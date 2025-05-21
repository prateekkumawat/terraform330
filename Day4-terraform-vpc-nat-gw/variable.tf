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