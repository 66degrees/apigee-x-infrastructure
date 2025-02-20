# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 5.0"
#     }
#     google-beta = {
#       source  = "hashicorp/google-beta"
#       version = "~> 5.0"
#     }
#     apigee = {
#       source  = "scastria/apigee"
#       version = "~> 0.1.0"
#     }
#   }
# }

# provider "google" {
#   project     = var.project_id
#   region      = var.region
#   credentials = file(var.credentials_file)
# }

# provider "google-beta" {
#   project     = var.project_id
#   region      = var.region
#   credentials = file(var.credentials_file)
# }

# provider "apigee" {
#   username      = var.apigee_username
#   password      = var.apigee_password
#   organization  = var.apigee_org
#   server        = "apigee.googleapis.com"
#   use_ssl       = true
# }
