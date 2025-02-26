output "instance_endpoints" {
  description = "Map of instance name -> internal runtime endpoint IP address"
  value = tomap({
    for name, instance in module.apigee-x-instance : name => instance.endpoint
  })
}

output "instance_service_attachments" {
  description = "Map of instance region -> instance PSC service attachment"
  value = tomap({
    for name, instance in module.apigee-x-instance : instance.instance.location => instance.instance.service_attachment
  })
}

output "instance_map" {
  description = "Map of instance region -> instance object"
  value = tomap({
    for name, instance in module.apigee-x-instance : instance.instance.location => instance.instance
  })
}

output "org_id" {
  description = "Apigee Organization ID"
  value       = module.apigee.org_id
}

output "organization" {
  description = "Apigee Organization."
  value       = module.apigee.org
}

output "environments" {
  description = "Apigee Organization ID"
  value       = module.apigee.envs
}

output "apigee_psc_service_name" {
  value = {
    for name, instance in module.apigee-x-instance : instance.instance.location => instance.service_attachment
  }
}
