variable "instances" {
  description = "Map cau hinh cac EC2"
  type = map(object({
    ami           = string
    instance_type = string
    name          = string
    env           = string
  }))
}

variable "deployment_bucket" {
  description = "Ten bucket S3 chua deployment package"
  type        = string
}
