resource "aws_instance" "servers" {
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = var.key_name
  iam_instance_profile   = var.instance_profile_name

  user_data = <<-EOF
              <powershell>
              Set-ExecutionPolicy Unrestricted -Force
              New-Item -Path "C:\\temp" -ItemType Directory -Force
              cd "C:\\temp"
              Invoke-WebRequest -Uri https://aws-codedeploy-${var.region}.s3.${var.region}.amazonaws.com/latest/codedeploy-agent.msi -OutFile codedeploy-agent.msi
              Start-Process msiexec.exe -Wait -ArgumentList '/i codedeploy-agent.msi /quiet'
              Start-Service -Name codedeployagent
              </powershell>
              EOF

  tags = {
    Name = each.value.name
    Env  = each.value.env
  }
}



