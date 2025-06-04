output "subnet_created" {
  description = "Details of all the VPC created"
  value = {
    for k, v in aws_subnet.main : k => {
      arn            = v.arn
      id             = v.id
      owner_id       = v.owner_id
      tags_all       = v.tags_all
    }
  }
}