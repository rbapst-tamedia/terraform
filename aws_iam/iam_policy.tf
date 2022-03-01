variable "deploy_terraform" {
  description = "If IAM user access key has to be managed by terraform ?"
  default     = false
}

# Policy for the github action workflows in https://github.com/tx-pts-dai organisation
# Follwing Best Practices, 20Min and Disco use groups to assign policies
resource "aws_iam_user" "cicd-github-actions" {
  name = "cicd-github-actions"
  path = "/technical/cicd/"
}

resource "aws_iam_group" "github-actions" {
  name = "github-actions"
}

resource "aws_iam_group_membership" "github-actions" {
  name = "github-actions"

  users = [
    aws_iam_user.cicd-github-actions.name,
  ]

  group = aws_iam_group.github-actions.name
}

resource "aws_iam_group_policy_attachment" "github-actions" {
  group      = aws_iam_group.github-actions.name
  policy_arn = data.aws_iam_policy.administrator.arn
}

# for testing purpose I use this as policy. It will be replaced by
# an explicit policy
data "aws_iam_policy" "administrator" {
  # arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Not used for the moment
# resource "aws_iam_policy" "github-actions" {
#   name        = "github-actions"
#   description = "To let tx-pts-dai github actions run workflows"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = [
#           "",
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

#!WARNING! Secret ID + Secret Key will be in terraform state file
#To rotate access key:
# 1) terraform taint aws_iam_access_key.cicd-github-actions
# 2) run workflow
resource "aws_iam_access_key" "cicd-github-actions" {
  count = var.deploy_terraform ? 1 : 0

  user = aws_iam_user.cicd-github-actions.name
}

resource "aws_secretsmanager_secret" "github-actions" {
  count = var.deploy_terraform ? 1 : 0

  name                    = "github-actions"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "github-actions" {
  count = var.deploy_terraform ? 1 : 0

  secret_id     = aws_secretsmanager_secret.github-actions.id
  secret_string = "{\"A_K\": \"${aws_iam_access_key[0].cicd-github-actions.id}\",\"A_S\": \"${aws_iam_access_key[0].cicd-github-actions.secret}\"}"
}
