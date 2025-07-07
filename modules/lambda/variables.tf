variable "raw_bucket_name" {
  description = "Tên S3 bucket raw"
  type        = string
}

variable "raw_bucket_arn" {
  description = "ARN S3 bucket raw"
  type        = string
}

variable "processed_bucket_name" {
  description = "Tên S3 bucket processed"
  type        = string
}

variable "processed_bucket_arn" {
  description = "ARN S3 bucket processed"
  type        = string
}

variable "deployment_bucket_name" {
  description = "Tên bucket chứa deployment package"
  type        = string
}

variable "deployment_bucket_arn" {
  description = "ARN bucket chứa deployment package"
  type        = string
}
