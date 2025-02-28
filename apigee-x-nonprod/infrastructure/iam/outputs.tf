output "apigee_developers_binding" {
  description = "IAM binding for the Apigee Developers group"
  value       = google_project_iam_binding.apigee_developers.id
}
output "apigee_developers_role" {
  description = "IAM role for the Apigee Developers group"
  value       = google_project_iam_binding.apigee_developers.role
}
output "apigee_developers_members" {
  description = "IAM members for the Apigee Developers group"
  value       = google_project_iam_binding.apigee_developers.members
}