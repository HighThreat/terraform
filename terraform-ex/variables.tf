variable "resource_group_name" {
  description = "Base name for the Resource Group."
  type        = string
}

variable "location" {
  description = "Azure region where the infrastructure will be deployed."
  type        = string
}

variable "vnet_cidr" {
  description = "Primary CIDR block for the VNET."
  type        = string
}

variable "subnet_names" {
  description = "Names for the two subnets."
  type        = list(string)

  validation {
    condition     = length(var.subnet_names) == 2
    error_message = "Exactly two subnet names are required."
  }
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the two subnets."
  type        = list(string)

  validation {
    condition     = length(var.subnet_cidrs) == 2
    error_message = "Exactly two subnet CIDRs are required."
  }
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}

variable "import_existing_resource_group_name" {
  description = "Optional existing Resource Group name to declare for manual import exercises."
  type        = string
  default     = null
}
