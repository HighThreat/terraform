variable "resource_group_name" {
  description = "Name of the bootstrap resource group to host backend storage."
  type        = string
  default     = "rg-backend-leo"
}

variable "location" {
  description = "Azure region for the backend resources."
  type        = string
  default     = "France Central"
}

variable "storage_account_prefix" {
  description = "Prefix for generated storage account name (will add short suffix)."
  type        = string
  default     = "leostorage"
}

variable "container_name" {
  description = "Blob container name for the backend state."
  type        = string
  default     = "leocontainer"
}

variable "vnet_cidr" {
  description = "CIDR block for the bootstrap virtual network."
  type        = string
  default     = "10.50.0.0/16"
}

variable "subnet_names" {
  description = "Names for two subnets created by the bootstrap."
  type        = list(string)
  default     = ["app", "data"]

  validation {
    condition     = length(var.subnet_names) == 2
    error_message = "Exactly two subnet names are required."
  }
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the two bootstrap subnets."
  type        = list(string)
  default     = ["10.50.1.0/24", "10.50.2.0/24"]

  validation {
    condition     = length(var.subnet_cidrs) == 2
    error_message = "Exactly two subnet CIDRs are required."
  }
}
