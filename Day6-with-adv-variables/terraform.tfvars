aws_region = "ap-south-1"

web = {
    "app-server" = { 
        ami_id = "ami-0fd05997b4dff7aac"
        instance_type = "t2.micro"
        key_name = "mount.pem"
        security_groups = ["launch-wizard-1"]
    } 

    "micro-server-1" = { 
        ami_id = "ami-0fd05997b4dff7aac"
        instance_type = "t2.micro"
        key_name = "mount.pem"
        security_groups = ["launch-wizard-1"]
    } 
  
    "micro-server-2" = { 
        ami_id = "ami-0fd05997b4dff7aac"
        instance_type = "t2.small"
        key_name = "mount.pem"
        security_groups = ["launch-wizard-1"]
    }        
}

vpc_details = { 
    "pp" = {
        cidr_block = "10.10.0.0/16"
    }

    "prod" = { 
        cidr_block = "10.20.0.0/16"
    }
}