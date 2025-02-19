resource "google_tags_tag_binding" "binding" {
  for_each  = coalesce(var.tag_bindings, {})
  parent    = "//cloudresourcemanager.googleapis.com/${local.keyring.id}"
  tag_value = each.value
}