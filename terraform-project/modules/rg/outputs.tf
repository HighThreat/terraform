output "rg_name" {
  value       = azurerm_resource_group.this.name
  description = "The name of the created Resource Group."
}

output "rg_location" {
  value       = azurerm_resource_group.this.location
  description = "The location of the created Resource Group."
}
