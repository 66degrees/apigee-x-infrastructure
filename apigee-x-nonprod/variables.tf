variable "project_id" {
  description = "Project id (also used for the Apigee Organization)."
  type        = string
}

variable "analytics_region" {
  description = "GCP region for storing Apigee analytics data (see https://cloud.google.com/apigee/docs/api-platform/get-started/install-cli)."
  type        = string
}

# variable "network" {
#   description = "Network (self-link) to peer with the Apigee tennant project."
#   type        = string
# }

variable "billing_type" {
  description = "Billing type of the Apigee organization."
  type        = string
  default     = null
}

variable "apigee_envgroups" {
  description = "Apigee Environment Groups."
  type = map(object({
    environments = list(string)
    hostnames    = list(string)
  }))
  default = {}
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

variable "apigee_instances" {
  description = "Apigee Instances (only one instance for EVAL)."
  type = map(object({
    region       = string
    ip_range     = string
    environments = list(string)
  }))
  default = {}
}

variable "org_key_rotation_period" {
  description = "Rotaton period for the organization DB encryption key"
  type        = string
  default     = "2592000s" #30days
}

variable "instance_key_rotation_period" {
  description = "Rotaton period for the instance disk encryption key"
  type        = string
  default     = "2592000s" #30days
}

variable "apigee_org_kms_keyring_name" {
  description = "Name of the KMS Key Ring for Apigee Organization DB."
  type        = string
  default     = "apigee-x-org"
}

variable "runtime_type" {
  description = "Apigee runtime type. Must be `CLOUD` or `HYBRID`."
  type        = string
  validation {
    condition     = contains(["CLOUD", "HYBRID"], var.runtime_type)
    error_message = "Allowed values for runtime_type \"CLOUD\" or \"HYBRID\"."
  }
}

variable "target_servers" {
  type = map(object({
    env      = string
    host     = string
    port     = number
    protocol = string
  }))
}
