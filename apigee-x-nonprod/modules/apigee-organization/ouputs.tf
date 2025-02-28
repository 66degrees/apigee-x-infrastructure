output "envs" {
  description = "Apigee Environments."
  value       = { for k, v in google_apigee_environment.apigee_env : k => v.name }
}

output "org" {
  description = "Apigee Organization."
  value       = google_apigee_organization.apigee_org.name
}

output "org_ca_certificate" {
  description = "Apigee organization CA certificate."
  value       = google_apigee_organization.apigee_org.ca_certificate
}

output "org_id" {
  description = "Apigee Organization ID."
  value       = google_apigee_organization.apigee_org.id
}

output "subscription_type" {
  description = "Apigee subscription type."
  value       = google_apigee_organization.apigee_org.subscription_type
}

output "target_server_ids" {
  description = "A map of the created Apigee target server IDs."
  value       = { for key, ts in google_apigee_target_server.gke_target_servers : key => ts.id }
}

output "target_server_names" {
  description = "A map of the created Apigee target server names."
  value       = { for key, ts in google_apigee_target_server.gke_target_servers : key => ts.name }
}
