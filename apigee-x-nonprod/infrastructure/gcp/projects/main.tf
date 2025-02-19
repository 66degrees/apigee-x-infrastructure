resource "google_project" "project" {
  for_each = var.projects

  name            = each.value.name
  project_id      = each.value.project_id
  folder_id       = each.value.folder_id
  org_id          = each.value.org_id
  billing_account = each.value.billing_account
}