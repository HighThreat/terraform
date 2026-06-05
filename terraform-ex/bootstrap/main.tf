resource "random_id" "sa_suffix" {
  byte_length = 4
}

locals {
  generated_sa_name = substr(lower(join("", [var.storage_account_prefix, random_id.sa_suffix.hex])), 0, 24)
}

resource "azurerm_resource_group" "backend_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "backend_sa" {
  name                     = local.generated_sa_name
  resource_group_name      = azurerm_resource_group.backend_rg.name
  location                 = azurerm_resource_group.backend_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "backend_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backend_sa.name
  container_access_type = "private"
}

resource "azurerm_virtual_network" "bootstrap_vnet" {
  name                = "leo-vnet"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name
  address_space       = [var.vnet_cidr]
}

resource "azurerm_network_security_group" "bootstrap_nsg" {
  name                = "leo-nsg"
  location            = azurerm_resource_group.backend_rg.location
  resource_group_name = azurerm_resource_group.backend_rg.name

  security_rule {
    name                       = "AllowVnetInBound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}

locals {
  subnet_map = { for idx, name in var.subnet_names : name => var.subnet_cidrs[idx] }
}

resource "azurerm_subnet" "bootstrap_subnets" {
  for_each = local.subnet_map

  name                 = each.key
  resource_group_name  = azurerm_resource_group.backend_rg.name
  virtual_network_name = azurerm_virtual_network.bootstrap_vnet.name
  address_prefixes     = [each.value]
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  for_each = azurerm_subnet.bootstrap_subnets

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.bootstrap_nsg.id
}
