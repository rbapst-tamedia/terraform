#
# Data
#
data "local_file" "main" {
  filename = "${path.module}/main.tf"
}
