###-------------------------------------------------------------------------------------------------------------------------------###
# Resource to create Apigee X instance
###-------------------------------------------------------------------------------------------------------------------------------###
resource "google_apigee_instance" "apigee_instance" {
  org_id                   = var.apigee_org_id
  name                     = var.name
  location                 = var.region
  ip_range                 = var.ip_range
  disk_encryption_key_name = var.disk_encryption_key
  consumer_accept_list     = var.consumer_accept_list
}

###-------------------------------------------------------------------------------------------------------------------------------###
# Resource to attach Apigee X instance to Apigee Environments
###-------------------------------------------------------------------------------------------------------------------------------###

resource "google_apigee_instance_attachment" "apigee_instance_attchment" {
  for_each    = toset(var.apigee_environments)
  instance_id = google_apigee_instance.apigee_instance.id
  environment = each.key
}