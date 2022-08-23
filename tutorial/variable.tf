#
# Variables
#
variable "github_repo" {
  description = "Used to tag resource, name of this repo"
  type        = string
  default     = "https://github.com/rbapst-tamedia/terraform/tree/master/tutorial"
}

variable "file_content" {
  description = "The content of the generated file"
  type        = string
}

variable "deploy_file" {
  description = "If the file should be deployed"
  type        = bool
}
