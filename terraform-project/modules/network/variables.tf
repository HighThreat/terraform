variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Virtual Network"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNET"
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
    nsg_name         = string
  }))
  description = "Map of subnets and their associated NSG names"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
