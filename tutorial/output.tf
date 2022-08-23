output "random" {
  value = random_pet.this
}

output "main_tf" {
  value = data.local_file.main.content
}
