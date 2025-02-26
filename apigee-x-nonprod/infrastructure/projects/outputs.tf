# output "project_ids" {
#   description = "Map of created project IDs."
#   value       = { for key, proj in google_project.project : key => proj.project_id }
# }

# output "project_numbers" {
#   description = "Map of created project numbers."
#   value       = { for key, proj in google_project.project : key => proj.number }
# }