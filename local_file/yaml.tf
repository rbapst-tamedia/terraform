locals {
  app-name = "my-application-name"
  landscape = "prod"
}

resource "local_file" "my" {
  content  = <<EOT
branch-defaults:
  default:
    environment: ${local.landscape}-${local.app-name}

environment-defaults:
  prod-sfts-app-node-env:
    branch: null
    repository: null
global:
  application_name: prod-sfts-app
  default_ec2_keyname: null
  default_platform: Node.js 12 running on 64bit Amazon Linux 2
  default_region: eu-central-1
  include_git_submodules: true
  instance_profile: null
  platform_name: null
  platform_version: null
  sc: git
  workspace_type: Application
EOT
  filename = "${path.module}/tf-generated-file.yaml"
}
