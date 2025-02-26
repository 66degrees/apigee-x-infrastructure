variable "project_id" {
  description = "The GCP project ID where the monitoring dashboard will be created."
  type        = string
}
variable "dashboard_files" {
  type        = map(any)
  description = "List of json files for each dashboard to create"
}