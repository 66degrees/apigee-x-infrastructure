variable "project_id" {
  description = "The project ID where logging should be enabled"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate this project with"
  type        = string
}

variable "default_region" {
  description = "Default region for resources."
  type        = list(string)
}

variable "monitoring_project_name" {
  description = "Name of the monitoring project"
  type        = string
}










































# variable "org_id" {
#   description = "The organization id for the associated services"
#   type        = string
# }

# variable "folder_id" {
#   description = "Folder ID to create the project under it"
#   type        = string  
# }

# variable "billing_account" {
#   description = "The ID of the billing account to associate this project with"
#   type        = string
# }

# variable "default_region" {
#   description = "Default region for BigQuery resources."
#   type        = string
# }

# variable "parent_folder" {
#   description = "Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. Must be the same value used in previous step."
#   type        = string
#   default     = ""
# }

# variable "monitoring_project_name" {
#   description = "Name of the monitoring project"
#   type        = string
# }