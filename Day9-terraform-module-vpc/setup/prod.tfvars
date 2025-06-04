# alwys use .tfvars file to pass variables to the module
# and this snippet from Day9-terraform-module-vpc/setup/prod.tf
# command: terraform plan  -var-file="prod.tfvars" -state="hsit-prod-use1.tfstate"

aws_region          = "us-east-1"
orgnization         = "hsit"
enviornment         = "prod"
vpc_details = {
    use1-prod = {
      vpc_cidr_block       = "10.20.0.0/16"
      instance_tenancy     = "default"  
      enable_dns_hostnames = true
      enable_dns_support   = true 
      tags = {
        "Project"    = "DevOps"
        "Owner"      = "hsit-ops-team"
        "enviorment" = "prod"
        "created_by" = "Terraform"
        "Name"       = "use1-prod-vpc"
      }   
    }  
}

subnet_details = {
    use1-prod-public-subnet-az1 = {
      cidr_block              = "10.20.1.0/24"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = true
        vpc_key                   = "use1-prod"
        tags = {
          Name = "use1-prod-public-subnet-az1"
        }       
    }
}   

igw_details = {
    use1-prod-igw = {
      vpc_key = "use1-prod"
      tags    = {
        Name = "use1-prod-igw"
      }
    }
}