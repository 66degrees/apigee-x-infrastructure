output "network_id" {
  description = "The ID of the Apigee network"
  value       = google_compute_network.apigee_network.id
}

output "subnet_ids" {
  description = "The IDs of the Apigee subnets"
  value = {
    for k, v in google_compute_subnetwork.apigee_non_prod_subnet_runtime : k => v.id
  }
}


output "global_ip" {
  description = "Global IP address for Apigee Load Balancer"
  value       = google_compute_global_address.apigee_global_ip.address
}

output "ssl_certificate_id" {
  description = "The ID of the SSL certificate"
  value       = google_compute_managed_ssl_certificate.apigee_ssl_certificate.id
}

output "load_balancer_url_map" {
  description = "The URL map of the Apigee Load Balancer"
  value       = google_compute_url_map.apigee_url_map.id
}

output "backend_service_id" {
  description = "The ID of the backend service for Apigee"
  value       = google_compute_backend_service.apigee_backend.id
}

output "firewall_rule_id" {
  description = "The ID of the firewall rule allowing Apigee traffic"
  value       = google_compute_firewall.allow_apigee.id
}

# output "dns_zone_name" {
#   description = "The DNS zone name for Apigee"
#   value       = google_dns_managed_zone.apigee_dns_zone.name
# }

# output "psc_attachment_ids" {
#   description = "Service attachment IDs for Apigee PSC"
#   value = {
#     for k, v in google_compute_service_attachment.apigee_psc_attachment : k => v.id
#   }
# }

# output "gke_global_ip" {
#   description = "Global IP address for Apigee to GKE Load Balancer"
#   value       = google_compute_global_address.gke_global_ip.address
# }

# output "gke_backend_service_id" {
#   description = "The ID of the GKE backend service"
#   value       = google_compute_backend_service.gke_backend.id
# }

output "network" {
  description = "The Apigee network"
  value       = google_compute_network.apigee_network.self_link
}



output "psc_attachment_ids" {
  description = "Service attachment IDs for Apigee PSC"
  value = {
    for k, v in google_compute_service_attachment.apigee_psc_attachment : k => v.id
  }
}