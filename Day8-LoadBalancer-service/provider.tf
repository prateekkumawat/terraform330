terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.97.0"
    }
  }
  #  backend "s3" {
  #   bucket = "terraform-hsit-tfstate"
  #   key    = "highsky-prod-infra"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
   region = var.aws_region
}
