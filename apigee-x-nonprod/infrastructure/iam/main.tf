resource "google_project_iam_binding" "apigee_developers" {
  project = var.project_id
  role    = var.apigee_role

  members = [
    "group:${var.okta_group_developers}"
  ]
}