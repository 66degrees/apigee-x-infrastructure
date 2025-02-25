variable "project_id" {
  description = "Project ID to host this Apigee organization (will also become the Apigee Org name)."
  type        = string
}

variable "analytics_region" {
  description = "Analytics Region for the Apigee Organization (immutable). See https://cloud.google.com/apigee/docs/api-platform/get-started/install-cli."
  type        = string
}

variable "display_name" {
  description = "Display Name of the Apigee Organization."
  type        = string
  default     = null
}

variable "description" {
  description = "Description of the Apigee Organization."
  type        = string
  default     = "Apigee Organization created by tf module"
}

variable "authorized_network" {
  description = "VPC network self link (requires service network peering enabled (Used in Apigee X only)."
  type        = string
  default     = "test-vpc"
}

variable "runtime_type" {
  description = "Apigee runtime type. Must be `CLOUD` or `HYBRID`."
  type        = string
  validation {
    condition     = contains(["CLOUD", "HYBRID"], var.runtime_type)
    error_message = "Allowed values for runtime_type \"CLOUD\" or \"HYBRID\"."
  }
}

variable "billing_type" {
  description = "Billing type of the Apigee organization."
  type        = string
  default     = null
}

variable "database_encryption_key" {
  description = "Cloud KMS key self link (e.g. `projects/foo/locations/us/keyRings/bar/cryptoKeys/baz`) used for encrypting the data that is stored and replicated across runtime instances (immutable, used in Apigee X only)."
  type        = string
  default     = null
}

variable "apigee_environments" {
  description = "Apigee Environment Names."
  type = map(object({
    api_proxy_type  = optional(string, "API_PROXY_TYPE_UNSPECIFIED")
    deployment_type = optional(string, "DEPLOYMENT_TYPE_UNSPECIFIED")
  }))
  default = {}
  validation {
    condition     = alltrue([for k, v in var.apigee_environments : contains(["API_PROXY_TYPE_UNSPECIFIED", "PROGRAMMABLE", "CONFIGURABLE"], v.api_proxy_type)])
    error_message = "Allowed values for api_proxy_type \"API_PROXY_TYPE_UNSPECIFIED\", \"PROGRAMMABLE\" or \"CONFIGURABLE\"."
  }
  validation {
    condition     = alltrue([for k, v in var.apigee_environments : contains(["DEPLOYMENT_TYPE_UNSPECIFIED", "PROXY", "ARCHIVE"], v.deployment_type)])
    error_message = "Allowed values for deployment_type \"DEPLOYMENT_TYPE_UNSPECIFIED\", \"PROXY\" or \"ARCHIVE\"."
  }
}

variable "apigee_envgroups" {
  description = "Apigee Environment Groups."
  type = map(object({
    environments = list(string)
    hostnames    = list(string)
  }))
  default = {}
}