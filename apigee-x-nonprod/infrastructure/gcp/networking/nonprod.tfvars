project_id   = "saas-seed-project"   #need to update nonprod project id
network_name = "test-vpc"


subnet_regions = {
  northamerica-northeast1 = {
    region       = "northamerica-northeast1"
    runtime_cidr = "10.253.34.0/22"  # Subset of 10.253.32.0/19
    control_cidr = "10.253.35.0/28"  
  }
  us-central1 = {
    region       = "us-central1"
    runtime_cidr = "10.253.36.0/22"  # Subset of 10.253.32.0/19
    control_cidr = "10.253.37.0/28"
  }
  us-east4 = {
    region       = "us-east4"
    runtime_cidr = "10.253.38.0/22"  # Subset of 10.253.32.0/19
    control_cidr = "10.253.39.0/28"
  }
}




security_policy_name = "apigee-nonprod-security-policy"

trusted_ip_ranges = [
  "",
  ""
]

allow_rule_action   = "allow"
allow_rule_priority = 100
allow_rule_expression = "inIpRange(origin.ip, \"192.168.1.0/24\") || inIpRange(origin.ip, \"10.0.0.0/16\")"
allow_rule_description = "Allow only trusted sources to access Apigee"

deny_rule_action     = ""
deny_rule_priority   = 1000
deny_rule_expression = "true"
deny_rule_description = "Block all other traffic"






apigee_global_ip_name = "apigee-nonprod-global-ip"

ssl_certificate_name = "apigee-nonprod-ssl-certificate"
ssl_private_key_path = ""
ssl_certificate_path = ""

apigee_url_map_name = "apigee-nonprod-url-map"
apigee_https_proxy_name = "apigee-nonprod-https-proxy"
apigee_forwarding_rule_name = "apigee-nonprod-global-lb"

apigee_backend_service_name = "apigee-nonprod-backend-service"
apigee_backend_timeout_sec = 10
apigee_backend_port_name = "https"

apigee_health_check_name = "apigee-nonprod-health-check"
apigee_health_check_interval = 10
apigee_health_check_timeout = 5
apigee_health_check_port = 8443
apigee_health_check_path = "/health"

apigee_firewall_rule_name = "allow-nonprod-apigee-traffic"
apigee_firewall_ports = ["", ""]
apigee_firewall_target_tags = ["apigee-nonprod-runtime"]





dns_zone_name = "apigee-nonprod-dns-zone"
dns_name      = ""
dns_ttl       = 300

backend_port = 443

apigee_zones = {
  "northamerica-northeast1" = ""
  "us-central1"             = ""
  "us-east4"                = ""
}

apigee_regions = ["northamerica-northeast1", "us-central1", "us-east4"]


gke_global_ip_name         = "gke-nonprod-global-ip"
gke_url_map_name           = "gke-nonprod-url-map"
gke_https_proxy_name       = "gke-nonprod-https-proxy"
gke_forwarding_rule_name   = "gke-nonprod-global-lb"
gke_backend_service_name   = "gke-nonprod-backend-service"
gke_backend_timeout_sec    = 30

gke_zones = {
  "northamerica-northeast1" = ""
  "us-central1"             = ""
  "us-east4"                = ""
}


gke_health_check_name      = "gke-nonprod-health-check"
gke_health_check_port      = 443
gke_health_check_path      = "/health"
gke_health_check_interval  = 5
gke_health_check_timeout   = 5
gke_healthy_threshold      = 2
gke_unhealthy_threshold    = 2

gke_firewall_rule_name   = "gke-nonprod-firewall-rule"
gke_firewall_ports       = ["", ""]
gke_firewall_target_tags = ["gke-lb"]

gke_lb_port = ""