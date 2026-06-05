output "resource_group_name" {
  description = "Name of the deployed Resource Group."
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "ID of the deployed Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "storage_account_name" {
  description = "Name of the deployed Storage Account."
  value       = azurerm_storage_account.this.name
}

output "subnet_ids" {
  description = "IDs of the deployed subnets keyed by subnet name."
  value       = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}
