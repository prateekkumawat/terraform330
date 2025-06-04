output "vpc_created" {
  description = "List of VPC details created"
  value       = { 
    for k, v in local.vpc_block : k => { 
      id        = try(v.id, null)
      arn       = try(v.arn, null)
      tags_all  = try(v.tags_all, null)
      owner_id  = try(v.owner_id, null)
    }
  }
} 

output "subnet_created" {
  description = "Details of all the VPC created"
  value = {
    for k, v in local.subnet_block : k => {
        id        = try(v.id, null)
      arn       = try(v.arn, null)
      tags_all  = try(v.tags_all, null)
      owner_id  = try(v.owner_id, null)
    }
  }
}