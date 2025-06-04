resource "aws_vpc" "use1" {
  for_each    = local.vpc_block
    
    cidr_block            = each.value.vpc_cidr_block
    instance_tenancy      = each.value.instance_tenancy
    enable_dns_hostnames  = each.value.enable_dns_hostnames
    enable_dns_support    = each.value.enable_dns_support
    tags                  = each.value.tags     
  }

resource "aws_subnet" "useusubnet1" {
  for_each                = local.subnet_block
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  vpc_id                  = aws_vpc.use1[each.value.vpc_key].id
  tags                    = each.value.tags
}

resource "aws_internet_gateway" "use1" {
  for_each = local.igw_block

  vpc_id = aws_vpc.use1[each.value.vpc_key].id
  tags   = merge(each.value.tags, { Name = "${each.key}-igw" })
}

