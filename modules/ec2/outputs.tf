output "instance_ids" {
  description = "IDs cac EC2"
  value = { for k, inst in aws_instance.servers : k => inst.id }
}

output "instance_public_ips" {
  description = "Public IP cac EC2"
  value = { for k, inst in aws_instance.servers : k => inst.public_ip }
}

output "instance_tags" {
  description = "Tags Name & Env"
  value = {
    for k, inst in aws_instance.servers :
    k => {
      Name = inst.tags.Name
      Env  = inst.tags.Env
    }
  }
}


