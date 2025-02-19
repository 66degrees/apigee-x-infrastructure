output "endpoint" {
  description = "Internal endpoint of the Apigee instance."
  value       = google_apigee_instance.apigee_instance.host
}

output "id" {
  description = "Apigee instance ID."
  value       = google_apigee_instance.apigee_instance.id
}

output "instance" {
  description = "Apigee instance."
  value       = google_apigee_instance.apigee_instance
}

output "port" {
  description = "Port number of the internal endpoint of the Apigee instance."
  value       = google_apigee_instance.apigee_instance.port
}

output "service_attachment" {
  description = "Resource name of the service attachment created for this Apigee instance."
  value       = google_apigee_instance.apigee_instance.service_attachment
}
