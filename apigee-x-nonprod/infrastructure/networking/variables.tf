variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "network_name" {
  description = "The name of the Apigee network"
  type        = string
}

variable "subnet_regions" {
  description = "Map of regions with CIDR ranges for runtime and control subnets"
  type = map(object({
    region       = string
    runtime_cidr   = string
    control_cidr = string
  }))
}



variable "security_policy_name" {
  description = "The name of the Cloud Armor security policy"
  type        = string
}

variable "allow_rule_action" {
  description = "Action for the allow rule"
  type        = string
}

variable "allow_rule_priority" {
  description = "Priority for the allow rule"
  type        = number
}

variable "allow_ip_ranges" {
  description = "List of IPs allowed"
  type        = list(string)
}
variable "allow_rule_description" {
  description = "Description for the allow rule"
  type        = string
}

variable "deny_rule_action" {
  description = "Action for the deny rule"
  type        = string
}

variable "deny_rule_priority" {
  description = "Priority for the deny rule"
  type        = number
  default     = 1000
}

variable "deny_ip_ranges" {
  description = "List of IPs to deny"
  type        = list(string)
}

variable "deny_rule_description" {
  description = "Description for the deny rule"
  type        = string
  default     = "Deny non-trusted sources"
}






variable "apigee_global_ip_name" {
  description = "Global IP address for Apigee Load Balancer"
  type        = string
}

# variable "ssl_certificate_name" {
#   description = "Name of the SSL certificate for HTTPS"
#   type        = string
# }

# variable "ssl_private_key_path" {
#   description = "Path to the private key file"
#   type        = string
# }

# variable "ssl_certificate_path" {
#   description = "Path to the SSL certificate file"
#   type        = string
# }

variable "apigee_url_map_name" {
  description = "Name of the URL Map"
  type        = string
}

variable "apigee_https_proxy_name" {
  description = "Name of the Target HTTPS Proxy"
  type        = string
}

variable "apigee_forwarding_rule_name" {
  description = "Name of the Global Forwarding Rule"
  type        = string
}

variable "apigee_backend_service_name" {
  description = "Name of the Backend Service"
  type        = string
}

variable "apigee_backend_timeout_sec" {
  description = "Timeout for the backend service"
  type        = number
}

variable "apigee_backend_port_name" {
  description = "Port name for the backend service"
  type        = string
}

variable "balancing_mode" {
  description = "Balancing mode for the backend service"
  type        = string
}

variable "max_rate_per_endpoint" {
  description = "Maximum rate per endpoint"
  type        = number
}
variable "apigee_health_check_name" {
  description = "Name of the health check"
  type        = string
}

variable "apigee_health_check_interval" {
  description = "Interval for health checks"
  type        = number
}

variable "apigee_health_check_timeout" {
  description = "Timeout for health checks"
  type        = number
}

variable "apigee_healthy_threshold" {
  description = "Healthy threshold for health check"
  type        = number
}

variable "apigee_unhealthy_threshold" {
  description = "Unhealthy threshold for health check"
  type        = number
}

variable "apigee_health_check_port" {
  description = "Port for health checks"
  type        = number
}

variable "apigee_health_check_path" {
  description = "Request path for health checks"
  type        = string
}

variable "apigee_firewall_rule_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "apigee_firewall_ports" {
  description = "List of ports allowed for Apigee"
  type        = list(string)
}

variable "apigee_firewall_target_tags" {
  description = "Target tags for firewall rule"
  type        = list(string)
}







# variable "dns_zone_name" {
#   description = "Name of the DNS zone"
#   type        = string
# }

# variable "dns_name" {
#   description = "DNS name for Apigee"
#   type        = string
# }

variable "dns_ttl" {
  description = "TTL for DNS records"
  type        = number
}
variable "dns_records" {
  type = map(string)
}

variable "dns_zones" {
  type = map(string)
  default = {
    "co.uk" = "apigee.appliedcloudservices.co.uk."
    "ca"    = "apigee.appliedcloudservices.ca."
    "com"   = "apigee.appliedcloudservices.com."
  }
}






variable "backend_port" {
  description = "Backend port for Apigee"
  type        = number
}

variable "apigee_zones" {
  description = "Mapping of regions to their respective zones for Apigee NEG"
  type        = map(list(string))
}


variable "apigee_regions" {
  description = "List of regions for Apigee Private Service Connect"
  type        = list(string)
}

variable "gke_global_ip_name" {
  description = "Name of the GKE global IP"
  type        = string
}

variable "gke_url_map_name" {
  description = "Name of the GKE URL Map"
  type        = string
}

variable "gke_https_proxy_name" {
  description = "Name of the GKE Target HTTPS Proxy"
  type        = string
}

variable "gke_forwarding_rule_name" {
  description = "Name of the GKE Global Forwarding Rule"
  type        = string
}

variable "gke_backend_service_name" {
  description = "Name of the GKE Backend Service"
  type        = string
}

variable "gke_backend_timeout_sec" {
  description = "Timeout in seconds for the backend service"
  type        = number
}

variable "gke_zones" {
  description = "List of zones for GKE instance groups"
  type        = map(string)
}

variable "gke_health_check_name" {
  description = "Name of the GKE health check"
  type        = string
}

variable "gke_health_check_port" {
  description = "Port for the GKE health check"
  type        = number
}

variable "gke_health_check_path" {
  description = "Health check request path"
  type        = string
}

variable "gke_health_check_interval" {
  description = "Health check interval in seconds"
  type        = number
}

variable "gke_health_check_timeout" {
  description = "Timeout for health checks"
  type        = number
}

variable "gke_healthy_threshold" {
  description = "Healthy threshold for health check"
  type        = number
}

variable "gke_unhealthy_threshold" {
  description = "Unhealthy threshold for health check"
  type        = number
}

variable "gke_firewall_rule_name" {
  description = "Name of the firewall rule allowing LB to GKE traffic"
  type        = string
}

variable "gke_firewall_ports" {
  description = "Allowed ports for GKE firewall"
  type        = list(string)
}

variable "gke_firewall_target_tags" {
  description = "Target tags for GKE firewall"
  type        = list(string)
}

variable "gke_lb_port" {
  description = "Port for the GKE Load Balancer"
  type        = string
}



































