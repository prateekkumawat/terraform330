# alwys use .tfvars file to pass variables to the module
# and this snippet from Day9-terraform-module-vpc/setup/prod.tf
# command: terraform plan  -var-file="pp.tfvars" -state="hsit-pp-use1.tfstate"

aws_region          = "ap-south-1"
orgnization         = "hsit"
enviornment         = "pp"
vpc_details = {
    use1-pp = {
      vpc_cidr_block       = "10.10.0.0/16"
      instance_tenancy     = "default"  
      enable_dns_hostnames = true
      enable_dns_support   = true 
      tags = {
        "Project"    = "DevOps"
        "Owner"      = "hsit-ops-team"
        "enviorment" = "pp"
        "created_by" = "Terraform"
        "Name"       = "use1-pp-vpc"
      }   
    }  
}

subnet_details = {
    use1-pp-public-subnet-az1 = {
      cidr_block              = "10.10.1.0/24"
        availability_zone       = "ap-south-1a"
        map_public_ip_on_launch = true
        vpc_key                   = "use1-pp"
        tags = {
          Name = "use1-pp-public-subnet-az1"
        }       
    }
}   

igw_details = {
    use1-pp-igw = {
      vpc_key = "use1-pp"
      tags    = {
        Name = "use1-pp-igw"
      }
    }
}