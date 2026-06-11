output "public_ips" {
  value       = module.compute.public_ips
  description = "Public IP addresses of the deployed VMs."
}

output "vm_names" {
  value       = module.compute.vm_names
  description = "Names of the deployed VMs."
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "The ID of the Virtual Network."
}

output "storage_account_name" {
  value       = module.storage.storage_account_name
  description = "The name of the created Storage Account."
}
