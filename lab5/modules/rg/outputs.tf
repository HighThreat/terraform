output "rg_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the Resource Group created."
}

output "rg_id" {
  value       = azurerm_resource_group.this.id
  description = "The ID of the Resource Group created."
}

output "rg_location" {
  value       = azurerm_resource_group.this.location
  description = "The location of the Resource Group created."
}
