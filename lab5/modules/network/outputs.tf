output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "The ID of the Virtual Network created."
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "The name of the Virtual Network created."
}

output "subnet_ids" {
  value       = azurerm_subnet.subnets[*].id
  description = "List of IDs of the subnets created."
}
