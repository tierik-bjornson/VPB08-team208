# Raw bucket
output "raw_bucket_name" {
  description = "Tên bucket raw"
  value       = aws_s3_bucket.raw.bucket
}

output "raw_bucket_arn" {
  description = "ARN bucket raw"
  value       = aws_s3_bucket.raw.arn
}

# Processed bucket
output "processed_bucket_name" {
  description = "Tên bucket processed"
  value       = aws_s3_bucket.processed.bucket
}

output "processed_bucket_arn" {
  description = "ARN bucket processed"
  value       = aws_s3_bucket.processed.arn
}

# Deployment package bucket
output "deployment_package_bucket" {
  description = "Tên bucket chứa deployment package"
  value       = aws_s3_bucket.deployment_package.bucket
}

output "deployment_package_bucket_arn" {
  description = "ARN bucket chứa deployment package"
  value       = aws_s3_bucket.deployment_package.arn
}

# Report bucket 
output "report_bucket_name" {
  description = "Tên bucket report"
  value       = aws_s3_bucket.report.bucket
}

output "report_bucket_arn" {
  description = "ARN bucket report"
  value       = aws_s3_bucket.report.arn
}

