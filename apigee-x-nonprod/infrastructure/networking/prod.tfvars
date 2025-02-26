project_id   = ""  #need to update prod project id
network_name = "production-vpc"


subnet_regions = {
  northamerica-northeast1 = {
    region       = "northamerica-northeast1"
    runtime_cidr = "10.252.34.0/22"  # Subset of 10.252.32.0/19
    control_cidr = "10.252.35.0/28"
  }
  us-central1 = {
    region       = "us-central1"
    runtime_cidr = "10.252.36.0/22"  # Subset of 10.252.32.0/19
    control_cidr = "10.252.37.0/28"
  }
  us-east4 = {
    region       = "us-east4"
    runtime_cidr = "10.252.38.0/22"  # Subset of 10.252.32.0/19
    control_cidr = "10.252.39.0/28"
  }
}






security_policy_name = "armor-security-policy"

allow_rule_action   = "allow"
allow_rule_priority = 1000
allow_ip_ranges = ["192.0.2.0/24"]
allow_rule_description = "Allow only trusted sources to access Apigee"

deny_rule_action     = "deny(403)"
deny_rule_priority   = 2147483647
deny_ip_ranges = ["*"]
deny_rule_description = "Block all other traffic"






apigee_global_ip_name = "apigee-prod-global-ip"

ssl_certificate_name = "apigee-prod-ssl-certificate"
ssl_private_key_path = ""
ssl_certificate_path = ""

apigee_url_map_name = "apigee-prod-url-map"
apigee_https_proxy_name = "apigee-prod-https-proxy"
apigee_forwarding_rule_name = "apigee-prod-global-lb"

apigee_backend_service_name = "apigee-prod-backend-service"
apigee_backend_timeout_sec = 10
apigee_backend_port_name = "https"

apigee_health_check_name = "apigee-prod-health-check"
apigee_health_check_interval = 10
apigee_health_check_timeout = 5
apigee_health_check_port = 8443
apigee_health_check_path = "/health"

apigee_firewall_rule_name = "allow-prod-apigee-traffic"
apigee_firewall_ports = ["", ""]
apigee_firewall_target_tags = ["apigee-prod-runtime"]
trusted_ip_ranges = [
  "192.168.1.0/24",
  "10.0.0.0/16"
]




dns_zone_name = "apigee-prod-dns-zone"
dns_name      = ""
dns_ttl       = 300

backend_port = 443

apigee_zones = {
  "northamerica-northeast1" = ""
  "us-central1"             = ""
  "us-east4"                = ""
}

apigee_regions = ["northamerica-northeast1", "us-central1", "us-east4"]


gke_global_ip_name         = "gke-prod-global-ip"
gke_url_map_name           = "gke-prod-url-map"
gke_https_proxy_name       = "gke-prod-https-proxy"
gke_forwarding_rule_name   = "gke-prod-global-lb"
gke_backend_service_name   = "gke-prod-backend-service"
gke_backend_timeout_sec    = 30

gke_zones = {
  "northamerica-northeast1" = ""
  "us-central1"             = ""
  "us-east4"                = ""
}


gke_health_check_name      = "gke-prod-health-check"
gke_health_check_port      = 443
gke_health_check_path      = "/health"
gke_health_check_interval  = 5
gke_health_check_timeout   = 5
gke_healthy_threshold      = 2
gke_unhealthy_threshold    = 2

gke_firewall_rule_name   = "gke-prod-firewall-rule"
gke_firewall_ports       = ["", ""]
gke_firewall_target_tags = ["gke-lb"]

gke_lb_port = ""