resource "google_monitoring_dashboard" "dashboard" {
  for_each       = var.dashboard_files
  dashboard_json = file("${each.value}")
  project        = var.project_id

  lifecycle {
    ignore_changes = [dashboard_json]
  }
}