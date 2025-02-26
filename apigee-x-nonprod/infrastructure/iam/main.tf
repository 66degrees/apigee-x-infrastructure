resource "google_project_iam_binding" "apigee_developers" {
  project = var.project_id
  role    = var.apigee_role_developer  

  members = [
    "group:${var.okta_group_developers}"  
  ]
}

resource "google_project_iam_binding" "apigee_admins" {
  project = var.project_id
  role    = var.apigee_role_admin  

  members = [
    "group:${var.okta_group_admins}"  
  ]
}