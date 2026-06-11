variable "location" {
  type        = string
  description = "Azure region"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VMs"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VMs"
  sensitive   = true
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
  description = "Subnets configuration mapped by name"
}

variable "vms" {
  type = map(object({
    vm_size    = string
    subnet_key = string
  }))
  description = "VMs configuration mapped by name"
}

variable "storage_account_name" {
  type        = string
  description = "Base name of the storage account (workspace will be appended)"
}

variable "container_name" {
  type        = string
  description = "Name of the blob container"
}
