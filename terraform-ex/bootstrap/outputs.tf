output "backend_resource_group" {
  value = azurerm_resource_group.backend_rg.name
}

output "backend_storage_account" {
  value = azurerm_storage_account.backend_sa.name
}

output "backend_container" {
  value = azurerm_storage_container.backend_container.name
}

output "bootstrap_vnet_id" {
  description = "ID of the bootstrap virtual network."
  value       = azurerm_virtual_network.bootstrap_vnet.id
}

output "bootstrap_subnet_ids" {
  description = "Map of subnet names to IDs created by the bootstrap."
  value       = { for name, s in azurerm_subnet.bootstrap_subnets : name => s.id }
}
