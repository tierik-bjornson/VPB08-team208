output "pipeline_names" {
  description = "Tên các pipeline"
  value = { for k, p in aws_codepipeline.pipelines : k => p.name }
}

output "codedeploy_apps" {
  description = "Tên các ứng dụng CodeDeploy"
  value = { for k, a in aws_codedeploy_app.apps : k => a.name }
}

output "codedeploy_groups" {
  description = "Tên các Deployment Group"
  value = { for k, g in aws_codedeploy_deployment_group.groups : k => g.deployment_group_name }
}

