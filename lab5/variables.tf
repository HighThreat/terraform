variable "rg_name" {
  type        = string
  description = "The name of the resource group to create."
  default     = "LeoLab5-rg"
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created. Restrained to allowed regions."
  default     = "westeurope"

  validation {
    condition     = contains(["westeurope", "northeurope", "eastus"], var.location)
    error_message = "The location must be one of the supported regions: westeurope, northeurope, or eastus."
  }
}

variable "vnet_cidr" {
  type        = string
  description = "The IP range in CIDR notation for the Virtual Network."
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrsubnet(var.vnet_cidr, 0, 0))
    error_message = "The VNET CIDR must be a valid IPv4 CIDR block (e.g. 10.0.0.0/16)."
  }
}

variable "subnet_count" {
  type        = number
  description = "The number of subnets to create sequentially."
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
  description = "Configuration details for creating multiple Network Security Groups via for_each."
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

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine. Enforces alphanumeric, hyphens, max 15 chars."
  default     = "LeoLab5-vm"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,15}$", var.vm_name))
    error_message = "The VM name must be alphanumeric and hyphens only, and between 1 and 15 characters long."
  }
}

variable "vm_size" {
  type        = string
  description = "The size/sku of the Virtual Machine."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "The administrator username for the VM."
  default     = "azureuser"
}

variable "ssh_public_key_path" {
  type        = string
  description = "The path to the SSH public key file."
  default     = "../id_rsa.pub"
}

variable "tags" {
  type        = map(string)
  description = "The common tags applied to all resources."
  default = {
    Environment = "Lab5"
    ManagedBy   = "Terraform"
    Course      = "Terraform-Lab"
  }
}
