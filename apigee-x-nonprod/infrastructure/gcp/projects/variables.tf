variable "projects" {
  description = "Map of GCP projects to be created. Each key is a unique identifier, and the value is an object with project details."
  type = map(object({
    name            = string
    project_id      = string
    folder_id       = string  
    org_id          = string
    billing_account = string
  }))
  default = {}
}