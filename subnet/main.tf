resource "aws_subnet" "useusubnet1" {
  for_each                = local.subnet_block
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch
  vpc_id                  = aws_vpc.use1.id
  tags                    = each.value.tags

  depends_on = [ module.vpc.var.vpc_created ]
}
