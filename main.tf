terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "s3" {
  source = "./modules/s3"

  raw_bucket_name        = "vpbraw-bucket"
  processed_bucket_name  = "vpbprocessed-bucket"
  deployment_bucket_name = "vpbdeployment-package-bucket"
  report_bucket_name     = "vpbreport-bucket"
}

module "keypair" {
  source   = "./modules/keypair"
  key_name = "vpb-key"
}

resource "aws_iam_role" "ec2_codedeploy_role" {
  name = "ec2_codedeploy_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_codedeploy" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

resource "aws_iam_role_policy_attachment" "attach_s3" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_codedeploy_instance_profile"
  role = aws_iam_role.ec2_codedeploy_role.name
}

module "ec2" {
  source = "./modules/ec2"

  instances = var.instances
  key_name  = module.keypair.key_name
  region    = var.aws_region
  instance_profile_name = aws_iam_instance_profile.ec2_instance_profile.name
}

module "codepipeline" {
  source            = "./modules/codepipeline"
  instances         = var.instances
  deployment_bucket = module.s3.deployment_package_bucket
}

module "lambda" {
  source = "./modules/lambda"

  raw_bucket_name         = module.s3.raw_bucket_name
  raw_bucket_arn          = module.s3.raw_bucket_arn
  processed_bucket_name   = module.s3.processed_bucket_name
  processed_bucket_arn    = module.s3.processed_bucket_arn
  deployment_bucket_name  = module.s3.deployment_package_bucket
  deployment_bucket_arn   = module.s3.deployment_package_bucket_arn
}

