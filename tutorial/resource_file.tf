# Doc: https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
resource "local_file" "this" {
  count = var.deploy_file ? 1 : 0

  content  = var.file_content
  filename = "${path.module}/mon_fichier.txt"
}
