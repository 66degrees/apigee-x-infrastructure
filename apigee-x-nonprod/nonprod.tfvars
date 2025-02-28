project_id                  = "saas-seed-project" #need to update nonprod project id
analytics_region            = "us-central1"
apigee_org_kms_keyring_name = "apigee-org-kms-keyring"
org_key_rotation_period     = "2592000s" # 30 days rotation period
runtime_type                = "CLOUD"
billing_type                = ""
# network                    = "test-vpc"

# Apigee Environments – these define our non-prod environments
apigee_environments = {
  development = {
    api_proxy_type  = "PROGRAMMABLE" # have to specify API Proxy Type for dev                    #need to ask
    deployment_type = "PROXY"        # have to specify Deployment Type for dev
  }
  staging = {
    api_proxy_type  = "CONFIGURABLE" # have to specify API Proxy Type for staging
    deployment_type = "ARCHIVE"      # have to specify Deployment Type for staging
  }
}

# Apigee Environment Groups – defines groups with virtual hosts
apigee_envgroups = {
  default = {
    hostnames    = ["api.example.com"]                                                                #need to ask
    environments = ["development", "staging"]
  }
}

# GKE Load Balancers – defines the GKE Load Balancers for each environment
target_servers = {
  docservice_us = {
    env      = "development"
    host     = "docservice.us.development.appliedcloudplatform.com"
    port     = 443
    protocol = "HTTP"
  }
  docservice_ca = {
    env      = "development" # Must match one of your apigee_environments keys
    host     = "docservice.ca.development.appliedcloudplatform.com"
    port     = 443
    protocol = "HTTP"
  }

  docservice_uk = {
    env      = "development"
    host     = "docservice.uk.development.appliedcloudplatform.com"
    port     = 443
    protocol = "HTTP"
  }
}


# Apigee Instances – define each Apigee instance configuration and Multiple Instances Per Region
apigee_instances = {
  "us-central1" = {
    region       = "us-central1"
    ip_range     = "10.253.32.0/22"                                                              #need to ask
    environments = ["Development", "Staging"]
  },
  "northamerica-northeast1" = {
    region       = "northamerica-northeast1"
    ip_range     = "10.253.36.0/22"
    environments = ["Development", "Staging"]
  },
  "us-east4" = {
    region       = "us-east4"
    ip_range     = "10.253.40.0/22"
    environments = ["Development", "Staging"]
  }
}

# Rotation period for instance disk encryption keys
instance_key_rotation_period = "2592000s"