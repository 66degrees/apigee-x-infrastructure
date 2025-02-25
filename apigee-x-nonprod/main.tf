resource "google_project_service_identity" "apigee_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "apigee.googleapis.com"
}

# module "kms-org-db" {
#   source     = "./modules/kms"
#   project_id = var.project_id
#   key_iam = {
#     org-db = {
#       "roles/cloudkms.cryptoKeyEncrypterDecrypter" = ["serviceAccount:${google_project_service_identity.apigee_sa.email}"]
#     }
#   }
#   keyring = {
#     location = var.analytics_region
#     name     = var.apigee_org_kms_keyring_name
#   }
#   keys = {
#     org-db = { rotation_period = var.org_key_rotation_period, labels = null }
#   }
# }

module "apigee" {
  source                  = "./modules/apigee-organization"
  project_id              = var.project_id
  analytics_region        = var.analytics_region
  runtime_type            = var.runtime_type
  billing_type            = var.billing_type
  authorized_network      = var.network
  # database_encryption_key = module.kms-org-db.key_ids["org-db"]
  apigee_environments     = var.apigee_environments
  apigee_envgroups        = var.apigee_envgroups
  depends_on = [
    google_project_service_identity.apigee_sa,
    # module.kms-org-db.id
  ]
}

# module "kms-inst-disk" {
#   for_each   = var.apigee_instances
#   source     = "./modules/kms"
#   project_id = var.project_id
#   key_iam = {
#     inst-disk = {
#       "roles/cloudkms.cryptoKeyEncrypterDecrypter" = ["serviceAccount:${google_project_service_identity.apigee_sa.email}"]
#     }
#   }
#   keyring = {
#     location = each.value.region
#     name     = "apigee-${each.key}"
#   }
#   keys = {
#     inst-disk = { rotation_period = var.instance_key_rotation_period, labels = null }
#   }
# }

module "apigee-x-instance" {
  for_each            = var.apigee_instances
  source              = "./modules/apigee-x-instance"
  apigee_org_id       = module.apigee.org_id
  name                = each.key
  region              = each.value.region
  ip_range            = each.value.ip_range
  apigee_environments = each.value.environments
  # disk_encryption_key = module.kms-inst-disk[each.key].key_ids["inst-disk"]
  depends_on = [
    google_project_service_identity.apigee_sa,
    # module.kms-inst-disk.self_link
  ]
}

