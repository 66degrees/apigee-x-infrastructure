project_id   = "saas-seed-project" 
network_name = "test-vpc"


subnet_regions = {                                         #need to ask for the correct CIDR ranges     
  northamerica-northeast1 = {
    region       = "northamerica-northeast1"
    runtime_cidr = "10.253.32.0/22" # Subset of 10.253.32.0/19                     #need to ask                     
    control_cidr = "10.253.36.0/28"                                                #need to ask
  }
  us-central1 = {
    region       = "us-central1"
    runtime_cidr = "10.253.40.0/22" # Subset of 10.253.32.0/19
    control_cidr = "10.253.44.0/28"
  }
  us-east4 = {
    region       = "us-east4"
    runtime_cidr = "10.253.48.0/22" # Subset of 10.253.32.0/19
    control_cidr = "10.253.52.0/28"
  }
}




security_policy_name = "armor-security-policy"

allow_rule_action      = "allow"
allow_rule_priority    = 1000
allow_ip_ranges        = ["192.0.2.0/24"]                                            #need to ask
allow_rule_description = "Allow only trusted sources to access Apigee"

deny_rule_action      = "deny(403)"
deny_rule_priority    = 2147483647
deny_ip_ranges        = ["*"]
deny_rule_description = "Block all other traffic"






apigee_global_ip_name = "apigee-nonprod-global-ip"


ssl_certificate_name = "apigee-ssl-certificate"
domains            = [
  "apigee-dev-temp.appliedcloudservices.com",
  "apigee-dev-temp.appliedcloudservices.ca",
  "apigee-dev-temp.appliedcloudservices.uk"
]


apigee_url_map_name         = "apigee-nonprod-url-map"
apigee_https_proxy_name     = "apigee-nonprod-https-proxy"
apigee_forwarding_rule_name = "apigee-nonprod-global-lb"

apigee_backend_service_name = "apigee-nonprod-backend-service"
apigee_backend_timeout_sec  = 10
apigee_backend_port_name    = "https"
balancing_mode              = "RATE"
max_rate_per_endpoint       = 1000

apigee_health_check_name     = "apigee-nonprod-health-check"
apigee_health_check_interval = 10
apigee_health_check_timeout  = 5
apigee_healthy_threshold     = 2
apigee_unhealthy_threshold   = 2
apigee_health_check_port     = 8443
apigee_health_check_path     = "/health"

apigee_firewall_rule_name   = "allow-nonprod-apigee-traffic"
apigee_firewall_ports       = ["", ""]
apigee_firewall_target_tags = ["apigee-nonprod-runtime"]




dns_zones = {
  "co.uk" = "appliedcloudservices.co.uk."
  "ca"    = "appliedcloudservices.ca."
  "com"   = "appliedcloudservices.com."
}

dns_ttl = 300
dns_records = {
  "api-dev-temp.co.uk" = "api-dev-temp.apigee.appliedcloudservices.co.uk."
  "api-dev-temp.ca"    = "api-dev-temp.apigee.appliedcloudservices.ca."
  "api-dev-temp.com"   = "api-dev-temp.apigee.appliedcloudservices.com."
}


backend_port = 443


apigee_regions = ["northamerica-northeast1", "us-central1", "us-east4"]