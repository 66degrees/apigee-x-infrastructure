project_id                 = "saas-seed-project"
analytics_region           = ""
apigee_org_kms_keyring_name = ""
org_key_rotation_period    = "2592000s"       # 30 days rotation period
runtime_type               = "CLOUD"
billing_type               = ""
network                    = ""

# Apigee Environments – these define our non-prod environments
apigee_environments = {
  dev = {
    api_proxy_type  = ""  # have to specify API Proxy Type for dev
    deployment_type = ""  # have to specify Deployment Type for dev
  }
  staging = {
    api_proxy_type  = ""  # have to specify API Proxy Type for staging
    deployment_type = ""  # have to specify Deployment Type for staging
  }
}

# Apigee Environment Groups – defines groups with virtual hosts
apigee_envgroups = {
  default = {
    hostnames    = [""]  # Specify virtual hosts for the environment group
    environments = ["dev", "staging"]
  }
}

# Apigee Instances – define each Apigee instance configuration and Multiple Instances Per Region
apigee_instances = {
  "us-central1-instance1" = {
    region           = "us-central1"
    ip_range         = "" 
    environments     = ["Development", "Staging"]
    key_name         = ""
    keyring_location = ""
    keyring_create   = true
    key_labels       = {}
  },
  "northamerica-northeast1-instance1" = {
    region           = "northamerica-northeast1"
    ip_range         = ""
    environments     = ["Development", "Staging"]
    key_name         = ""
    keyring_location = ""
    keyring_create   = true
    key_labels       = {}
  },
  "us-east4-instance1" = {
    region           = "us-east4"
    ip_range         = "1" 
    environments     = ["Development", "Staging"]
    key_name         = ""
    keyring_location = ""
    keyring_create   = true
    key_labels       = {}
  }
}

# Rotation period for instance disk encryption keys
instance_key_rotation_period = "2592000s"