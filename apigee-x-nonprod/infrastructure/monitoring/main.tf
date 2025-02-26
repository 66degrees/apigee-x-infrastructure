# resource "google_monitoring_dashboard" "dashboard" {
#   project = var.project_id

#   dashboard_json = <<EOF
# {
#   "displayName": "${var.dashboard_name}",
#   "gridLayout": {
#     "widgets": [
#       {
#         "blank": {}
#       }
#     ]
#   }
# }
# EOF
# }

# Deploy monitoring dashboards from JSON file list #

resource "google_monitoring_dashboard" "dashboard" {
  for_each       = var.dashboard_files
  dashboard_json = file("${each.value}")
  project        = var.project_id

  lifecycle {
    ignore_changes = [dashboard_json]
  }
}