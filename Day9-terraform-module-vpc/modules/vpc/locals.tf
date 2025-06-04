locals {
  vpc_block   = { 
    for  k, v in var.vpc_details  : k => {
    
    vpc_cidr_block          = v.vpc_cidr_block
    prefix                  = v.prefix
    instance_tenancy        = v.instance_tenancy
    enable_dns_hostnames    = v.enable_dns_hostnames == "" ? true : v.enable_dns_hostnames
    enable_dns_support      = v.enable_dns_support == "" ? true : v.enable_dns_support
    #tags                   = merge( v.tags, v.prefix == null ? tomap ({ Name = "${v.Name}" }) : tomap ({ Name = "${v.prefix}-${v.Name}" }))
    tags                    = v.tags
    }
  } 
}

locals {
  subnet_block = {
    for k, v in var.subnet_details : k => {
      cidr_block        = v.cidr_block
      availability_zone = v.availability_zone
      vpc_key            = v.vpc_key
      map_public_ip_on_launch = v.map_public_ip_on_launch == "" ? true : v.map_public_ip_on_launch
      #tags = merge(v.tags, v.prefix == null ? tomap({ Name = "${v.Name}" }) : tomap({ Name = "${v.prefix}-${v.Name}" }))
      tags = v.tags == null ? {} : v.tags    
    }
  }
}

locals {
  igw_block = {
    for k, v in var.igw_details : k => {
      vpc_key = v.vpc_key
      tags    = merge(v.tags, { Name = "${k}-igw" })
    }
  }
}

