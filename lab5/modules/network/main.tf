resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_cidr]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnets" {
  count                = var.subnet_count
  name                 = "LeoLab5-subnet-${count.index}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 8, count.index)]
}

resource "azurerm_network_security_group" "nsgs" {
  for_each            = var.nsg_configs
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc" {
  count     = min(var.subnet_count, length(keys(var.nsg_configs)))
  subnet_id = azurerm_subnet.subnets[count.index].id
  network_security_group_id = count.index == 0 ? (
    contains(keys(var.nsg_configs), "mgmt") ? azurerm_network_security_group.nsgs["mgmt"].id : values(azurerm_network_security_group.nsgs)[0].id
    ) : (
    contains(keys(var.nsg_configs), "web") ? azurerm_network_security_group.nsgs["web"].id : values(azurerm_network_security_group.nsgs)[1 % length(keys(var.nsg_configs))].id
  )
}
