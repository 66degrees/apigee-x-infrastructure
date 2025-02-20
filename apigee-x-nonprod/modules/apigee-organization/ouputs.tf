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