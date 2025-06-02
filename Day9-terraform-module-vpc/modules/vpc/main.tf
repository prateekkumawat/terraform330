resource "aws_vpc" "use1" {
  for_each = var.vpc_details 
    # For each block allows us to create multiple VPCs based on the map provided in var.vpc_details
    cidr_block = each.value.vpc_cidr_block
    instance_tenancy = each.value.instance_tenancy
    enable_dns_hostnames = each.value.enable_dns_hostnames
    enable_dns_support = each.value.enable_dns_support
    tags = merge(
      {
        "Name" = "${var.orgnization}-${var.enviornment}-${each.key}-vpc"
      },
      each.value.tags
    )
}

resource "aws_subnet" "useusubnet1" {
  for_each = var.subnet_details
  cidr_block = each.value.subnet_cidr
  availability_zone = each.value.availability_zones
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  vpc_id = each.value.vpc_id
  tags = merge(
    {
      Name = "${var.orgnization}-${var.enviornment}-publicsubnet-${each.value.availability_zones}"
    },
    each.value.tags
  ) 
}
