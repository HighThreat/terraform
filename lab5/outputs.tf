output "rg_id" {
  value       = module.rg.rg_id
  description = "The ID of the Resource Group created."
}

output "rg_name" {
  value       = module.rg.rg_name
  description = "The name of the Resource Group created."
}

output "vnet_id" {
  value       = module.network.vnet_id
  description = "The ID of the Virtual Network created."
}

output "subnet_ids" {
  value       = module.network.subnet_ids
  description = "The IDs of the subnets created."
}

output "vm_public_ip" {
  value       = module.vm.vm_public_ip
  description = "The public IP address of the VM."
}

output "vm_id" {
  value       = module.vm.vm_id
  description = "The ID of the VM created."
}
