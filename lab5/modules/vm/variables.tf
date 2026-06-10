variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group."
}

variable "location" {
  type        = string
  description = "The Azure region where the VM resources will be created."
}

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine."
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID to connect the Network Interface Card (NIC) to."
}

variable "vm_size" {
  type        = string
  description = "The SKU size of the Virtual Machine."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the VM."
  default     = "azureuser"
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH public key content to use for authentication."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources."
  default     = {}
}
