variable "aws_region" {
    description = "please enter your region"  
}

variable "aws_access_key" {
   description = "please enter your access key"  
}

variable "aws_secret_key" {
   description = "please enter your secret  key"  
}

variable "aws_ami_image" {
    description = "please enter your aws ami"  
}

variable "aws_instnace_type" {
    description = "please enter your aws instnace types"  
}

variable "orgnization" {}
variable "enviornment" {}
variable "vpc_cidr_block" {}
variable "subnet_cidr" {
  type = list
}
variable "az" {
  type = list
}