variable "aws_region" {}

variable "web" {
   description = "map values for web ec2 instance"
   type = map(object({   
        ami_id = string
        instance_type = string 
        key_name = string
        security_groups = list(string)
    }))
}

variable "vpc_details" {
    description = "map values for vpc create"
    type  = map(object({ 
       cidr_block = string
       instance_tenancy = optional(string)
       enable_dns_hostnames = optional(bool)
       enable_dns_support = optional(bool)
    })) 
}
