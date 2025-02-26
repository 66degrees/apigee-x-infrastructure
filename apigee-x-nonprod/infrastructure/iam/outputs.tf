output "apigee_developers_binding" {
  description = "IAM binding for the Apigee Developers group"
  value       = google_project_iam_binding.apigee_developers.id
}

output "apigee_admins_binding" {
  description = "IAM binding for the Apigee Admins group"
  value       = google_project_iam_binding.apigee_admins.id
}