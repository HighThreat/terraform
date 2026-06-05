resource "azurerm_resource_group" "imported" {
  count    = var.import_existing_resource_group_name == null ? 0 : 1
  name     = var.import_existing_resource_group_name
  location = var.location
  tags     = local.common_tags
}
