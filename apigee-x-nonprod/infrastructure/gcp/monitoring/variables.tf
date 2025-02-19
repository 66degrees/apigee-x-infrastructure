variable "project_id" {
  description = "The GCP project ID where the monitoring dashboard will be created."
  type        = string
}

variable "dashboard_name" {
  description = "The display name of the monitoring dashboard."
  type        = string
  default     = "Demo Dashboard"
}