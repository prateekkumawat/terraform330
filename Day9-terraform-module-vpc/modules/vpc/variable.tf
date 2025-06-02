variable "aws_region" {}
variable "orgnization" {}
variable "enviornment" {}
variable "vpc_details" {
  type = map(object({
    vpc_cidr_block           = string
    instance_tenancy         = optional(string)
    enable_dns_hostnames     = optional(bool, true)
    enable_dns_support       = optional(bool, true)
    tags                     = optional(map(string), {})
  }))
}

variable "subnet_details" {
  type = map(object({
    subnet_cidr              = string
    availability_zones       = string
    map_public_ip_on_launch = optional(bool, true)
    tags                    = optional(map(string), {})
  })) 
}