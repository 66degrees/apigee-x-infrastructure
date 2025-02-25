locals {
  env_pairs = flatten([
    for env_name, env in var.apigee_environments : {
      api_proxy_type  = env.api_proxy_type
      deployment_type = env.deployment_type
      env_name        = env_name
    }
  ])

  env_envgroup_pairs = flatten([
    for eg_name, eg in var.apigee_envgroups : [
      for e in eg.environments : {
        envgroup = eg_name
        env      = e
      }
    ]
  ])
}

###--------------------------------------------------------------------------------------------------------------------------------------###
### Create Apigee Organization
###--------------------------------------------------------------------------------------------------------------------------------------###
resource "google_apigee_organization" "apigee_org" {
  project_id         = var.project_id
  analytics_region   = var.analytics_region
  display_name       = var.display_name
  description        = var.description
  authorized_network = var.authorized_network
  runtime_type       = var.runtime_type
  billing_type       = var.billing_type
  runtime_database_encryption_key_name = var.database_encryption_key
}

###--------------------------------------------------------------------------------------------------------------------------------------###
### Create Apigee Environments
###--------------------------------------------------------------------------------------------------------------------------------------###

resource "google_apigee_environment" "apigee_env" {
  for_each        = { for env in local.env_pairs : env.env_name => env }
  # api_proxy_type  = each.value.api_proxy_type
  # deployment_type = each.value.deployment_type
  name            = each.key
  org_id          = google_apigee_organization.apigee_org.id
}

###--------------------------------------------------------------------------------------------------------------------------------------###
### Create Apigee Environment Groups
###--------------------------------------------------------------------------------------------------------------------------------------###

resource "google_apigee_envgroup" "apigee_envgroup" {
  for_each  = var.apigee_envgroups
  org_id    = google_apigee_organization.apigee_org.id
  name      = each.key
  hostnames = each.value.hostnames
}


resource "google_apigee_envgroup_attachment" "env_to_envgroup_attachment" {
  for_each    = { for pair in local.env_envgroup_pairs : "${pair.envgroup}-${pair.env}" => pair }
  envgroup_id = google_apigee_envgroup.apigee_envgroup[each.value.envgroup].id
  environment = google_apigee_environment.apigee_env[each.value.env].name
}