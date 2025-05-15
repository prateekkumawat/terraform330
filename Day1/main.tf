terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.97.0"
    }
  }
}

provider "aws" {
   region = "ap-south-1" 
  # access_key = "xxxxxxx"
  # secret_key = "xxxxxxx"
}

# Configure Resoure EC2 Instance 
resource "aws_instance" "instance1" {
  ami               = "ami-0af9569868786b23a"
  instance_type     = "t2.micro"
  key_name          =  "mount.pem" 
  security_groups   =  ["launch-wizard-13"]
  tags =  { 
    Name  =  "Launch-by-terraform"
  }
}

resource "aws_instance" "instance2" {
  ami               = "ami-0af9569868786b23a"
  instance_type     = "t2.micro"
  key_name          =  "mount.pem" 
  security_groups   =  ["launch-wizard-13"]
  tags =  { 
    Name  =  "Launch-by-terraform-again"
  }
}