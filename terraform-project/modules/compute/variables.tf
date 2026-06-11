variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vms" {
  type = map(object({
    vm_size   = string
    subnet_id = string
  }))
  description = "Map of VMs to create"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VMs"
  default     = "adminuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VMs"
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
