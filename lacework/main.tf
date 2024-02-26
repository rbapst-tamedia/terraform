terraform {
  required_version = "~> 1.3.0"

  required_providers {
    lacework = {
      source = "lacework/lacework"
    }
  }
}

provider "lacework" {}

# resource "datadog_api_key" "this" {
#   name = "rba-test-api-tf"
# }

# resource "datadog_application_key" "this" {
#   name = "rba-test-app-tf"
# }

resource "lacework_policy_exception" "example" {
  policy_id   = "lacework-global-72"
  description = "Test from terraform"
  constraint {
    field_key    = "resourceNames"
    field_values = ["rolandbapst"]
  }
}
