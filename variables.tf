variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "ap-southeast-1"
}

variable "key_name" {
  description = "Name for the EC2 Key Pair"
  default     = "my-keypair"
}

# S3 Bucket Names
variable "raw_bucket_name" {
  default = "my-raw-bucket"
}

variable "processed_bucket_name" {
  default = "my-processed-bucket"
}

variable "deployment_package_bucket_name" {
  default = "my-deployment-package-bucket"
}

variable "report_bucket_name" {
  default = "my-report-bucket"
}


# EC2
variable "instances" {
  description = "Map cau hinh EC2"
  type = map(object({
    ami           = string
    instance_type = string
    name          = string
    env           = string
  }))
}
