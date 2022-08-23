#
# Ressources
#

# Ressources à partir de locals
resource "local_file" "foo" {
  for_each = { for record in local.array_of_records : record.username => record }

  content  = each.value.email
  filename = "${path.module}/${each.value.username}.txt"
}

# Ressources à partir d'autres ressources
resource "local_file" "bar" {
  for_each = local_file.foo

  content  = each.value.content
  filename = "${each.value.filename}-2-${each.key}"
}
