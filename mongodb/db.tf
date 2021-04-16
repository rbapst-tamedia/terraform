terraform {
  required_providers {
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 3.0"
    # }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "~> 0.6.0"
    }
  }
}

#provider "aws" {}

provider "mongodbatlas" {}

resource "mongodbatlas_cluster" "this" {
  project_id                   = local.disco_sbx_project_id
  name                         = "rbatest"
  disk_size_gb                 = null
  backup_enabled               = false
  provider_backup_enabled      = true
  provider_encrypt_ebs_volume  = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.4"
  cluster_type                 = "REPLICASET"
  provider_name                = "AWS"
  backing_provider_name        = null
  provider_instance_size_name  = "M30"
  provider_region_name         = local.atlasmongodb_region_name
  provider_disk_iops           = 120
  provider_volume_type         = "PROVISIONED"
}

locals {
  disco_sbx_project_id     = "5e625cf90fd9df557bf6c79a"
  atlasmongodb_region_name = "EU_CENTRAL_1"
}
