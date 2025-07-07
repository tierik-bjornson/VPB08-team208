resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline_role"

  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume_role.json
}

data "aws_iam_policy_document" "codepipeline_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}


resource "aws_iam_role" "codedeploy_role" {
  name = "codedeploy_role"

  assume_role_policy = data.aws_iam_policy_document.codedeploy_assume_role.json
}

data "aws_iam_policy_document" "codedeploy_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}


resource "aws_codedeploy_app" "apps" {
  for_each = var.instances

  name             = "codedeploy-${each.key}"
  compute_platform = "Server"
}

resource "aws_codedeploy_deployment_group" "groups" {
  for_each = var.instances

  app_name              = aws_codedeploy_app.apps[each.key].name
  deployment_group_name = "${each.key}-group"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = each.value.name
    }
  }

  deployment_style {
    deployment_type  = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }
}


resource "aws_codepipeline" "pipelines" {
  for_each = var.instances

  name     = "pipeline-${each.key}"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.deployment_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket    = var.deployment_bucket
        S3ObjectKey = "${each.key}.zip"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      version         = "1"
      input_artifacts = ["source_output"]

      configuration = {
        ApplicationName     = aws_codedeploy_app.apps[each.key].name
        DeploymentGroupName = aws_codedeploy_deployment_group.groups[each.key].deployment_group_name
      }
    }
  }
}
