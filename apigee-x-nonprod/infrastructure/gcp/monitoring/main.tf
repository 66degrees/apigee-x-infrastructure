resource "google_monitoring_dashboard" "dashboard" {
  project = var.project_id

  dashboard_json = <<EOF
{
  "displayName": "${var.dashboard_name}",
  "gridLayout": {
    "widgets": [
      {
        "blank": {}
      }
    ]
  }
}
EOF
}