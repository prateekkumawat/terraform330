resource "aws_instance" "ins1" {
  for_each = var.web

  ami = each.value.ami_id
  instance_type = each.value.instance_type
  key_name = each.value.key_name
  security_groups = each.value.security_groups

  tags = { 
    Name = each.key
  }
}

resource "aws_vpc" "use1" {
  for_each = var.vpc_details 
  
  cidr_block = each.value.cidr_block
  instance_tenancy = each.value.instance_tenancy
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support = each.value.enable_dns_support
  
  tags = {
    Name = each.key
  }
}

