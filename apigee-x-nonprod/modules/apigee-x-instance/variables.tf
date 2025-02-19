variable "apigee_org_id" {
  description = "Apigee Organization ID."
  type        = string
}

variable "name" {
  description = "Apigee instance name."
  type        = string
}

variable "region" {
  description = "Compute region."
  type        = string
}

variable "ip_range" {
  description = "Input: Customer-provided CIDR blocks of length 22 (e.g. `10.0.0.0/22`) Output: Main and Support CIDR (e.g. `10.0.0.0/22,10.1.0.0/28`)."
  type        = string
  default     = null
}

variable "disk_encryption_key" {
  description = "Customer Managed Encryption Key (CMEK) self link (e.g. `projects/foo/locations/us/keyRings/bar/cryptoKeys/baz`) used for disk and volume encryption (required for PAID Apigee Orgs only)."
  type        = string
  default     = null
}

variable "consumer_accept_list" {
  description = "List of projects (id/number) that can privately connect to the service attachment."
  type        = list(string)
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
  type        = list(string)
  default     = []
}