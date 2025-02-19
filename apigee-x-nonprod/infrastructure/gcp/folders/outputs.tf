output "folder_ids" {
  description = "Map of created folder IDs."
  value       = { for key, folder in google_folder.folder : key => folder.id }
}