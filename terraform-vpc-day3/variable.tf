variable "aws_region" {}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_ami_image" {}

variable "aws_instnace_type" {}

variable "orgnization" {}
variable "enviornment" {}
variable "vpc_cidr_block" {}
variable "subnet_cidr" {
  type = list
}
variable "az" {
  type = list
}