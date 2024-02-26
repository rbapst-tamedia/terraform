terraform {
  required_version = "~> 1.3.0"

  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_url = "https://api.datadoghq.eu/"
}

data "datadog_api_key" "this" {
  name = "rba_test_org_api_key_not_used"
}

# resource "datadog_api_key" "this" {
#   name = "rba-test-api-tf"
# }

# resource "datadog_application_key" "this" {
#   name = "rba-test-app-tf"
# }

data "datadog_role" "this" {
  for_each = { for k, v in data.datadog_roles.this.roles : k => v.name }
  filter = each.value
}

data "datadog_roles" "this" {
  filter = "Datadog"
}

output "role" {
  value = data.datadog_role.this
}

