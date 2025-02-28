terraform {
  required_version = ">= 1.3.0" # Ensure Terraform CLI is up-to-date

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.64.0"  # Ensure you are using the latest version
    }
  }
}


#------------------------------------------------------------------------------------------------------------------#
# This file contains the terraform code to create the network and subnets.
#------------------------------------------------------------------------------------------------------------------#
resource "google_compute_network" "apigee_network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "apigee_non_prod_subnet_runtime" {
  for_each = var.subnet_regions

  name                     = "apigee-non-prod-subnet-${each.key}-runtime"
  region                   = each.value.region
  network                  = google_compute_network.apigee_network.id
  ip_cidr_range            = each.value.runtime_cidr
  project                  = var.project_id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "apigee_non_prod_subnet_control" {
  for_each = var.subnet_regions

  name                     = "apigee-non-prod-subnet-${each.key}-control"
  region                   = each.value.region
  network                  = google_compute_network.apigee_network.id
  ip_cidr_range            = each.value.control_cidr
  project                  = var.project_id
  private_ip_google_access = true
}






#------------------------------------------------------------------------------------------------------------------#
# This file contains the terraform code to create the Cloud Armor Security Policy
#------------------------------------------------------------------------------------------------------------------#
resource "google_compute_security_policy" "apigee_security_policy" {
  name    = var.security_policy_name
  project = var.project_id

  # Whitelist traffic from certain ip address
  rule {
    action   = var.allow_rule_action
    priority = var.allow_rule_priority
    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.allow_ip_ranges
      }
    }
    description = var.allow_rule_description
  }

  # Reject all traffic that hasn't been whitelisted.
  rule {
    action   = var.deny_rule_action
    priority = var.deny_rule_priority
    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.deny_ip_ranges
      }
    }
    description = var.deny_rule_description
  }
}







#------------------------------------------------------------------------------------------------------------------#
# This file contains the terraform code to create the Load Balancer and related resources.
#------------------------------------------------------------------------------------------------------------------#
resource "google_compute_global_address" "apigee_global_ip" {
  name    = var.apigee_global_ip_name
  project = var.project_id
}

resource "google_compute_managed_ssl_certificate" "apigee_ssl_certificate" {
  name    = var.ssl_certificate_name
  project = var.project_id
  managed {
    domains = var.domains
  }
}

# URL Map for Load Balancer
resource "google_compute_url_map" "apigee_url_map" {
  name            = var.apigee_url_map_name
  project         = var.project_id
  default_service = google_compute_backend_service.apigee_backend.id
}

# HTTPS Proxy
resource "google_compute_target_https_proxy" "apigee_https_proxy" {
  name             = var.apigee_https_proxy_name
  project          = var.project_id
  url_map          = google_compute_url_map.apigee_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.apigee_ssl_certificate.id]
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "apigee_forwarding_rule" {
  name       = var.apigee_forwarding_rule_name
  project    = var.project_id
  target     = google_compute_target_https_proxy.apigee_https_proxy.id
  ip_address = google_compute_global_address.apigee_global_ip.address
  port_range = "443"
}

# Backend Service
resource "google_compute_backend_service" "apigee_backend" {
  name                  = var.apigee_backend_service_name
  project               = var.project_id
  protocol              = "HTTPS"
  timeout_sec           = var.apigee_backend_timeout_sec
  load_balancing_scheme = "EXTERNAL"
  security_policy       = google_compute_security_policy.apigee_security_policy.id
  health_checks         = [google_compute_health_check.apigee_health_check.id]

  dynamic "backend" {
    for_each = google_compute_region_network_endpoint_group.apigee_psc_neg
    content {
      group                 = backend.value.id
      balancing_mode        = var.balancing_mode
      max_rate_per_endpoint = var.max_rate_per_endpoint
    }
  }

  port_name = var.apigee_backend_port_name
}

# Health Check
resource "google_compute_health_check" "apigee_health_check" {
  name                = var.apigee_health_check_name
  project             = var.project_id
  check_interval_sec  = var.apigee_health_check_interval
  timeout_sec         = var.apigee_health_check_timeout
  healthy_threshold   = var.apigee_healthy_threshold
  unhealthy_threshold = var.apigee_unhealthy_threshold


  https_health_check {
    port         = var.apigee_health_check_port
    request_path = var.apigee_health_check_path
  }
}

# Firewall Rule for Apigee Traffic
resource "google_compute_firewall" "allow_apigee" {
  name    = var.apigee_firewall_rule_name
  network = google_compute_network.apigee_network.id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = var.apigee_firewall_ports
  }

  source_ranges = [google_compute_global_address.apigee_global_ip.address]
  target_tags   = var.apigee_firewall_target_tags
}








#------------------------------------------------------------------------------------------------------------------#
# This file contains the terraform code to create the DNS Zones and Records.
#------------------------------------------------------------------------------------------------------------------#
resource "google_dns_managed_zone" "apigee_dns_zones" {
  for_each = var.dns_zones

  name       = "apigee-nonprod-dns-zone-${replace(each.key, ".", "-")}"
  project    = var.project_id
  dns_name   = each.value
  visibility = "private" # check with the team if this is correct, should we public or private dns

  private_visibility_config {
    networks {
      network_url = google_compute_network.apigee_network.id
    }
  }
}
# Define the DNS Records dynamically for each environment/region
resource "google_dns_record_set" "apigee_dns_record" {
  for_each = var.dns_records # Dynamically pass DNS records via a variable

  name         = each.value
  project      = var.project_id
  managed_zone = google_dns_managed_zone.apigee_dns_zones[replace(each.key, "api-dev-temp.", "")].name
  type         = "A"
  ttl          = var.dns_ttl
  rrdatas      = [google_compute_global_address.apigee_global_ip.address]
}






#------------------------------------------------------------------------------------------------------------------#
# This file contains the terraform code to create the Network Endpoint Groups and Forwarding Rules.
#------------------------------------------------------------------------------------------------------------------#

resource "google_compute_region_network_endpoint_group" "apigee_psc_neg" {
  for_each = toset(var.apigee_regions)
  name     = "apigee-psc-neg-${each.value}"
  project               = var.project_id
  region                = each.key
  network_endpoint_type = "PRIVATE_SERVICE_CONNECT"
  psc_target_service    = module["apigee-x-instance"][each.key].service_attachment
}
