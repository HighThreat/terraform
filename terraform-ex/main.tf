locals {
  workspace_name = lower(terraform.workspace)

  base_name = lower(join("-", [var.resource_group_name, local.workspace_name]))

  default_tags = {
    managed_by  = "terraform"
    environment = local.workspace_name
  }

  common_tags = merge(local.default_tags, var.tags)

  subnet_map = {
    for index, subnet_name in var.subnet_names : subnet_name => var.subnet_cidrs[index]
  }

  vnet_name = lower(join("-", [local.base_name, "vnet"]))

  nsg_name = lower(join("-", [local.base_name, "nsg"]))

  storage_account_name = substr(
    "${join("", regexall("[0-9a-z]", lower(join("", [var.resource_group_name, local.workspace_name, "sa"]))))}000",
    0,
    24
  )

  container_name = lower(join("-", [local.workspace_name, "data"]))
}

resource "azurerm_resource_group" "this" {
  name     = local.base_name
  location = var.location
  tags     = local.common_tags

  lifecycle {
    precondition {
      condition     = contains(["dev", "prod"], terraform.workspace)
      error_message = "Use the dev or prod workspace before applying this configuration."
    }
  }
}

resource "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.vnet_cidr]
  tags                = local.common_tags
}

resource "azurerm_network_security_group" "this" {
  name                = local.nsg_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = local.common_tags

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

  security_rule {
    name                       = "AllowAzureLoadBalancerInBound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DenyInternetInBound"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet" "this" {
  for_each = local.subnet_map

  name                 = each.key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = azurerm_subnet.this

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.this.id
}

resource "azurerm_storage_account" "this" {
  name                            = local.storage_account_name
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  tags                            = local.common_tags

  lifecycle {
    precondition {
      condition     = length(local.storage_account_name) >= 3
      error_message = "The generated storage account name must have at least 3 characters."
    }
  }
}

resource "azurerm_storage_container" "this" {
  name                  = local.container_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
