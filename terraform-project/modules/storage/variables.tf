variable "rg_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account"
}

variable "container_name" {
  type        = string
  description = "Name of the blob container"
}

variable "tags" {
  type        = map(string)
  description = "Tags for the resources"
  default     = {}
}
