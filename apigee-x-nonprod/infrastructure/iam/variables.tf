variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "apigee_role_developer" {
  description = "The IAM role for Apigee developers."
  type        = string
}

variable "apigee_role_admin" {
  description = "The IAM role for Apigee admins."
  type        = string
}

variable "okta_group_developers" {
  description = "The Okta group for developers."
  type        = string
}

variable "okta_group_admins" {
  description = "The Okta group for admins."
  type        = string
}