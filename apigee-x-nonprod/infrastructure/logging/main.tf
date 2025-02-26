locals {
  parent_resource_id   = var.parent_folder != "" ? var.parent_folder : var.org_id
  parent_resource_type = var.parent_folder != "" ? "folder" : "organization"
  main_logs_filter     = <<EOF
    logName: /logs/cloudaudit.googleapis.com%2Factivity OR
    logName: /logs/cloudaudit.googleapis.com%2Fsystem_event OR
    logName: /logs/compute.googleapis.com%2Fvpc_flows OR
    logName: /logs/compute.googleapis.com%2Ffirewall OR
    logName: /logs/cloudaudit.googleapis.com%2Faccess_transparency
EOF
  all_logs_filter      = ""
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}





module "log_export_to_storage" {
  source                 = "terraform-google-modules/log-export/google"
  version                = "~> 7.3.0"
  destination_uri        = module.storage_destination.destination_uri
  filter                 = local.all_logs_filter
  log_sink_name          = "logging-bkt"
  parent_resource_id     = local.parent_resource_id
  parent_resource_type   = local.parent_resource_type
  include_children       = true
  unique_writer_identity = true
}

module "storage_destination" {
  source                      = "terraform-google-modules/log-export/google//modules/storage"
  version                     = "~> 7.3.0"
  project_id                  = module.org_monitoring_project.project_id
  storage_bucket_name         = "sd-bkt-${module.org_monitoring_project.project_id}-org-logs-${random_string.suffix.result}"
  log_sink_writer_identity    = module.log_export_to_storage.writer_identity
  uniform_bucket_level_access = true
  lifecycle_rules = [
    {
      action = {
        type = "Delete"
      }
      condition = {
        age        = 365
        with_state = "ANY"
      }
    },
    {
      action = {
        type = "SetStorageClass"
        storage_class = "COLDLINE"
      }
      condition = {
        age        = 180
        with_state = "ANY"
      }
    }
  ]
}

module "org_monitoring_project" {
  source                      = "terraform-google-modules/project-factory/google"
  version                     = "~> 10.1"
  random_project_id           = "true"
  # Simpersonate_service_account = var.terraform_service_account
  name                        = var.monitoring_project_name
  org_id                      = var.org_id
  billing_account             = var.billing_account
  folder_id                   = var.folder_id
  disable_services_on_destroy = false
  activate_apis = [
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "billingbudgets.googleapis.com"
  ]

  labels = {
    environment       = "shared"
    application_name  = "env-monitoring"
    billing_code      = "xxxx"
    primary_contact   = "xxxx-xxxxxx"
    secondary_contact = "xxxx-xxxxxx"
    env_code          = "s"
  }
}