# Project and regional settings
project_id                  = "production-project-id"
analytics_region            = "us-central1"
apigee_org_kms_keyring_name = "apigee-prod-kms-keyring"
org_key_rotation_period     = "2592000s"  # 30 days

runtime_type  = "CLOUD"
billing_type  = "your-billing-type"  # Update with your production billing type

# Apigee Environments – only Production is defined
apigee_environments = {
  production = {
    api_proxy_type  = "CONFIGURABLE"   # Typically, production uses a stable, configurable proxy
    deployment_type = "ARCHIVE"        # Adjust based on our production requirements
  }
}

# Apigee Environment Groups – assign a production hostname and environments
apigee_envgroups = {
  default = {
    hostnames    = ["api-prod.example.com"]  # Replace with our actual production domain
    environments = ["production"]
  }
}

# Target Servers for Load Balancing (Production targets)
target_servers = {
  docservice_prod = {
    env      = "production"
    host     = "docservice.prod.example.com"  # Replace with our production target host
    port     = 443
    protocol = "HTTP"
  }
}

# Apigee Instances – each instance now supports only the production environment
apigee_instances = {
  "us-central1" = {
    region       = "us-central1"
    ip_range     = "10.253.32.0/22"
    environments = ["Production"]
  },
  "northamerica-northeast1" = {
    region       = "northamerica-northeast1"
    ip_range     = "10.253.36.0/22"
    environments = ["Production"]
  },
  "us-east4" = {
    region       = "us-east4"
    ip_range     = "10.253.40.0/22"
    environments = ["Production"]
  }
}

# Backend Service settings for production
apigee_backend_service_name = "apigee-prod-backend-service"
apigee_backend_timeout_sec   = 10
apigee_backend_port_name     = "https"
balancing_mode               = "RATE"
max_rate_per_endpoint        = 1000

# Rotation period for instance disk encryption keys
instance_key_rotation_period = "2592000s"

