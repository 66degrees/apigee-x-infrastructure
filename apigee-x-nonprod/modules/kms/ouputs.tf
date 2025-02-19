output "id" {
  description = "Keyring self link."
  value       = local.keyring.id
  depends_on = [
    google_kms_key_ring_iam_binding.default
  ]
}

output "key_ids" {
  description = "Key self links."
  value = {
    for name, resource in google_kms_crypto_key.default :
    name => resource.id
  }
  depends_on = [
    google_kms_crypto_key_iam_binding.default
  ]
}

output "keyring" {
  description = "Keyring resource."
  value       = local.keyring
  depends_on = [
    google_kms_key_ring_iam_binding.default
  ]
}

output "keys" {
  description = "Key resources."
  value       = google_kms_crypto_key.default
  depends_on = [
    google_kms_crypto_key_iam_binding.default
  ]
}

output "location" {
  description = "Keyring location."
  value       = local.keyring.location
  depends_on = [
    google_kms_key_ring_iam_binding.default
  ]
}

output "name" {
  description = "Keyring name."
  value       = local.keyring.name
  depends_on = [
    google_kms_key_ring_iam_binding.default
  ]
}