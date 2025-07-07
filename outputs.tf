# ============================================
# 🗝️ Key Pair Outputs
# ============================================

output "key_name" {
  description = "Ten keypair AWS"
  value       = module.keypair.key_name
}

output "private_key_path" {
  description = "File PEM da luu"
  value       = module.keypair.private_key_path
}
# ============================================
# 📦 S3 Buckets Outputs
# ============================================

output "raw_bucket" {
  description = "Tên bucket chứa raw file"
  value       = module.s3.raw_bucket_name
}

output "processed_bucket" {
  description = "Tên bucket chứa file đã xử lý"
  value       = module.s3.processed_bucket_name
}

output "deployment_package_bucket" {
  description = "Tên bucket chứa deployment package"
  value       = module.s3.deployment_package_bucket
}

output "report_bucket" {
  description = "Tên bucket chứa báo cáo"
  value       = module.s3.report_bucket_name
}

# ============================================
# 🖥️ EC2 Outputs
# ============================================

output "ec2_instance_ids" {
  description = "Danh sách ID EC2 instance đã tạo"
  value       = module.ec2.instance_ids
}

output "pipeline_names" {
  value = module.codepipeline.pipeline_names
}

output "codedeploy_apps" {
  value = module.codepipeline.codedeploy_apps
}

output "codedeploy_groups" {
  value = module.codepipeline.codedeploy_groups
}




