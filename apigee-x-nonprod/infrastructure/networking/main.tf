#  define the network and subnets for the Apigee X non-prod environment
resource "google_compute_network" "apigee_network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "apigee_non_prod_subnet_runtime" {
  for_each = var.subnet_regions

  name          = "apigee-non-prod-subnet-${each.key}-runtime"
  region        = each.value.region
  network       = google_compute_network.apigee_network.id
  ip_cidr_range = each.value.runtime_cidr
  project       = var.project_id
  private_ip_google_access = true
}

resource "google_compute_subnetwork" "apigee_non_prod_subnet_control" {
  for_each = var.subnet_regions

  name          = "apigee-non-prod-subnet-${each.key}-control"
  region        = each.value.region
  network       = google_compute_network.apigee_network.id
  ip_cidr_range = each.value.control_cidr
  project       = var.project_id
  private_ip_google_access = true
}







# Cloud Armor Security Policy
resource "google_compute_security_policy" "apigee_security_policy" {
  name = var.security_policy_name
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







# Global Load Balancer for Apigee
# Global IP Address for Apigee Load Balancer
resource "google_compute_global_address" "apigee_global_ip" {
  name = var.apigee_global_ip_name
  project = var.project_id
}

# # SSL Certificate for HTTPS Load Balancing
# resource "google_compute_ssl_certificate" "apigee_ssl" {
#   name         = var.ssl_certificate_name
#   project         = var.project_id
#   private_key  = file(var.ssl_private_key_path)
#   certificate  = file(var.ssl_certificate_path)
# }

resource "google_compute_managed_ssl_certificate" "apigee_ssl_certificate" {
  name = "apigee-ssl-certificate"
  project = var.project_id
  managed {
    domains = ["example.com"]  # Specify the domain for the certificate
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
  name            = var.apigee_https_proxy_name
  project         = var.project_id
  url_map        = google_compute_url_map.apigee_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.apigee_ssl_certificate.id]
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "apigee_forwarding_rule" {
  name       = var.apigee_forwarding_rule_name
  project     = var.project_id
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
    for_each = google_compute_network_endpoint_group.apigee_neg
    content {
      group = backend.value.id
      balancing_mode          = var.balancing_mode  
      max_rate_per_endpoint   = var.max_rate_per_endpoint  
    }
  }

  port_name = var.apigee_backend_port_name
}

# Health Check
resource "google_compute_health_check" "apigee_health_check" {
  name               = var.apigee_health_check_name
  project            = var.project_id
  check_interval_sec = var.apigee_health_check_interval
  timeout_sec        = var.apigee_health_check_timeout
  healthy_threshold  = var.apigee_healthy_threshold
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








# DNS Zone for Apigee
resource "google_dns_managed_zone" "apigee_dns_zones" {
  for_each = var.dns_zones

  name     = "apigee-nonprod-dns-zone-${replace(each.key, ".", "-")}" 
  project  = var.project_id
  dns_name = each.value
  visibility  = "private"  # check with the team if this is correct, should we public or private dns

  private_visibility_config {
    networks {
      network_url = google_compute_network.apigee_network.id
    }
  }
}
# Define the DNS Records dynamically for each environment/region
resource "google_dns_record_set" "apigee_dns_record" {
  for_each = var.dns_records  # Dynamically pass DNS records via a variable

  name         = each.value
  project      = var.project_id
  managed_zone = google_dns_managed_zone.apigee_dns_zones[replace(each.key, "api-dev-temp.", "")].name
  type         = "A"
  ttl          = var.dns_ttl
  rrdatas      = [google_compute_global_address.apigee_global_ip.address]
}




resource "google_compute_network_endpoint_group" "apigee_neg" {
  for_each = var.apigee_zones
  name                  = "apigee-neg-${each.key}"
  project               = var.project_id
  network               = google_compute_network.apigee_network.id
  subnetwork            = google_compute_subnetwork.apigee_non_prod_subnet_runtime[each.key].id
  default_port          = var.backend_port
  zone                  = each.value[0]
  # network_endpoint_type = "PRIVATE_SERVICE_CONNECT"
}

resource "google_compute_service_attachment" "apigee_psc_attachment" {
  for_each    = toset(var.apigee_regions)
  name        = "apigee-psc-attachment-${each.key}"
  project     = var.project_id
  region      = each.key
  nat_subnets = [google_compute_subnetwork.apigee_non_prod_subnet_runtime[each.key].id]

  enable_proxy_protocol = false
  connection_preference = "ACCEPT_AUTOMATIC"

  target_service = module.apigee_x_instance[each.key].psc_apigee_psc_service_name

}

resource "google_compute_forwarding_rule" "psc_endpoint" {
  for_each              = var.apigee_regions
  name                  = "apigee-psc-endpoint-${each.key}"
  network               = google_compute_network.apigee_network.id
  subnetwork            = google_compute_subnetwork.apigee_non_prod_subnet_runtime[each.key].id
  target                = google_compute_service_attachment.apigee_psc_attachment[each.key].id
  load_balancing_scheme = "INTERNAL"
  region                = each.key
}









resource "google_compute_global_address" "gke_global_ip" {
  name = var.gke_global_ip_name
  project = var.project_id
}

# URL Map for Backend Routing
resource "google_compute_url_map" "gke_url_map" {
  name            = var.gke_url_map_name
  project         = var.project_id  
  default_service = google_compute_backend_service.gke_backend.id
}

# Target HTTPS Proxy for Backend
resource "google_compute_target_https_proxy" "gke_https_proxy" {
  name            = var.gke_https_proxy_name
  project         = var.project_id
  url_map         = google_compute_url_map.gke_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.apigee_ssl_certificate.id]
}

# Global Forwarding Rule (Apigee to GKE)
resource "google_compute_global_forwarding_rule" "gke_forwarding_rule" {
  name       = var.gke_forwarding_rule_name
  project = var.project_id
  target     = google_compute_target_https_proxy.gke_https_proxy.id
  ip_address = google_compute_global_address.gke_global_ip.address
  port_range = var.gke_lb_port
}

# Backend Service for apigee to GKE
resource "google_compute_backend_service" "gke_backend" {
  name                  = var.gke_backend_service_name
  project               = var.project_id
  protocol              = "HTTPS"
  timeout_sec           = var.gke_backend_timeout_sec
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_health_check.gke_health_check.id]

  # dynamic "backend" {
  #   for_each = var.gke_zones
  #   content {
  #     # group = google_compute_instance_group.gke_instance_group[backend.key].id  #need to call clients gke cluster here
  #     balancing_mode  = "UTILIZATION"
  #     max_utilization = 1.0
  #     capacity_scaler = 1.0
  #   }
  # }
}

resource "google_compute_health_check" "gke_health_check" {
  name               = var.gke_health_check_name
  project = var.project_id
  check_interval_sec = var.gke_health_check_interval
  timeout_sec        = var.gke_health_check_timeout
  healthy_threshold  = var.gke_healthy_threshold
  unhealthy_threshold = var.gke_unhealthy_threshold

  https_health_check {
    port         = var.gke_health_check_port
    request_path = var.gke_health_check_path
  }
}


# Firewall rule to allow traffic from the Load Balancer to GKE

resource "google_compute_firewall" "allow_lb_to_gke" {
  name    = var.gke_firewall_rule_name
  network = google_compute_network.apigee_network.id
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = var.gke_firewall_ports
  }

  source_ranges = [google_compute_global_address.gke_global_ip.address]
  target_tags   = var.gke_firewall_target_tags
}