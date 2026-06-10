variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the networking resources."
}

variable "location" {
  type        = string
  description = "The Azure region where the networking resources will be created."
}

variable "vnet_name" {
  type        = string
  description = "The name of the Virtual Network."
  default     = "LeoLab5-vnet"
}

variable "vnet_cidr" {
  type        = string
  description = "The IP address space for the Virtual Network in CIDR notation."
  default     = "10.0.0.0/16"
}

variable "subnet_count" {
  type        = number
  description = "The number of subnets to create."
  default     = 2
}

variable "nsg_configs" {
  type = map(object({
    name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  description = "Configuration details for creating multiple Network Security Groups and their rules."
  default = {
    web = {
      name = "LeoLab5-web-nsg"
      rules = [
        {
          name                       = "allow-http"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        },
        {
          name                       = "allow-https"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
    mgmt = {
      name = "LeoLab5-mgmt-nsg"
      rules = [
        {
          name                       = "allow-ssh"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "22"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    }
  }
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}
