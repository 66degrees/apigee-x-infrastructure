variable "project_id" {
  description = "The ID of the GCP project."
  type        = string
}

variable "apigee_role" {
  description = "The IAM role for Apigee developers."
  type        = string
}
variable "okta_group_developers" {
  description = "The Okta group for developers."
  type        = string
}