aws_region          = "us-east-1"
orgnization         = "hsit"
enviornment         = "stage"

vpc_details = {
    use1-stage = {
      vpc_cidr_block       = "10.10.0.0/16"
      instance_tenancy     = "default"  
      enable_dns_hostnames = true
      enable_dns_support   = true 
      tags = {
        "Project"    = "DevOps"
        "Owner"      = "hsit-ops-team"
        "enviorment" = "stage"
        "created_by" = "Terraform"
        "Name"       = "higsky-use1-stage-vpc"
      }   
    }  
}

subnet_details = {
    use1-stage-public-subnet-az1 = {
      cidr_block              = "10.10.1.0/24"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = true
        vpc_id                   = "use1-stage"
        tags = {
          Name = "highsky-use1-stage-public-subnet-az1"
        }       
    }

    use1-stage-public-subnet-az2 = {
      cidr_block              = "10.10.2.0/24"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = true
        vpc_id                   = "use1-stage"
        tags = {
          Name = "highsky-use1-stage-public-subnet-az2"
        }       
    }
}        

igw_details = {
    use1-stage-igw = {
      vpc_key = "use1-stage"
      tags    = {
        Name = "highsky-use1-stage-igw"
      }
    }
}

