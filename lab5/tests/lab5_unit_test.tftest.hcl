mock_provider "azurerm" {
  mock_resource "azurerm_resource_group" {
    defaults = {
      id       = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/LeoLab5-rg"
      name     = "LeoLab5-rg"
      location = "westeurope"
    }
  }

  mock_resource "azurerm_virtual_network" {
    defaults = {
      id            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/LeoLab5-rg/providers/Microsoft.Network/virtualNetworks/LeoLab5-vnet"
      name          = "LeoLab5-vnet"
      address_space = ["10.0.0.0/16"]
    }
  }

  mock_resource "azurerm_subnet" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/LeoLab5-rg/providers/Microsoft.Network/virtualNetworks/LeoLab5-vnet/subnets/LeoLab5-subnet-0"
    }
  }

  mock_resource "azurerm_network_security_group" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/LeoLab5-rg/providers/Microsoft.Network/networkSecurityGroups/LeoLab5-web-nsg"
    }
  }

  mock_resource "azurerm_subnet_network_security_group_association" {
    defaults = {
      id = "assoc-id"
    }
  }

  mock_resource "azurerm_public_ip" {
    defaults = {
      id         = "public-ip-id"
      ip_address = "203.0.113.1"
    }
  }

  mock_resource "azurerm_network_interface" {
    defaults = {
      id = "nic-id"
    }
  }

  mock_resource "azurerm_storage_account" {
    defaults = {
      id                    = "storage-id"
      primary_blob_endpoint = "https://leolab5diagstorage.blob.core.windows.net/"
    }
  }

  mock_resource "azurerm_linux_virtual_machine" {
    defaults = {
      id = "vm-id"
    }
  }
}

variables {
  rg_name             = "LeoLab5-rg"
  location            = "westeurope"
  vnet_cidr           = "10.0.0.0/16"
  subnet_count        = 2
  vm_name             = "LeoLab5-vm"
  vm_size             = "Standard_B2s"
  admin_username      = "azureuser"
  ssh_public_key_path = "../id_rsa.pub"
  tags = {
    Environment = "Lab5"
    ManagedBy   = "Terraform"
    Course      = "Terraform-Lab"
  }
}

run "validate_rg" {
  command = plan

  assert {
    condition     = output.rg_name == "LeoLab5-rg"
    error_message = "Resource Group name output does not match expected value"
  }
}

run "validate_network" {
  command = plan

  assert {
    condition     = length(output.subnet_ids) == 2
    error_message = "Subnet count output should be 2"
  }
}
