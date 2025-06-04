locals {
  subnet_block = {
    for k, v in subnet_cidr_block : k => {
      cidr_block        = v.cidr_block
      availability_zone = v.availability_zone
      vpc_id            = modules.var.vpc_created.id
      map_public_ip_on_launch = v.map_public_ip_on_launch == "" ? true : v.map_public_ip_on_launch
      tags = merge(v.tags, v.prefix == null ? tomap({ Name = "${v.Name}" }) : tomap({ Name = "${v.prefix}-${v.Name}" }))
    }
  }
}