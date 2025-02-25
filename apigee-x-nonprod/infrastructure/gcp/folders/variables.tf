# variable "folders" {
#   description = "Map of GCP folders to be created. Each key is a unique identifier, and the value is an object with display_name and parent (e.g., organizations/123456789)."
#   type = map(object({
#     display_name = string
#     parent       = string
#   }))
#   default = {}
# }