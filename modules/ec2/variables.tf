variable "instances" {
  description = "Map cac EC2 config khac nhau"
  type = map(object({
    ami           = string
    instance_type = string
    name          = string
    env           = string
  }))
}

variable "key_name" {
  description = "Ten key pair EC2"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_profile_name" {
  description = "Ten IAM Instance Profile gan EC2"
  type        = string
}

