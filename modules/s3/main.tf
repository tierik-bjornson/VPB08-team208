resource "aws_s3_bucket" "raw" {
  bucket = var.raw_bucket_name
}

resource "aws_s3_bucket" "processed" {
  bucket = var.processed_bucket_name
}

resource "aws_s3_bucket" "deployment_package" {
  bucket = var.deployment_bucket_name
}

resource "aws_s3_bucket_versioning" "deployment_package_versioning" {
  bucket = aws_s3_bucket.deployment_package.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "deployment_package_sse" {
  bucket = aws_s3_bucket.deployment_package.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "report" {
  bucket = var.report_bucket_name
}



