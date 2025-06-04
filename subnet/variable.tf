variable "aws_region" {}
variable "orgnization" {}
variable "enviornment" {}
variable "subnet_details" {
  type = map(object({
    cidr_block              = string
    vpc_id                   = optional(string)
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, true)
    tags                    = optional(map(string), {})
  })) 
}