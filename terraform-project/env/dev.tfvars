location             = "West Europe"
admin_username       = "devadmin"
admin_password       = "P@ssw0rdGlobexDev!2026"
vnet_address_space   = ["10.0.0.0/16"]

subnets = {
  "subnet-web" = {
    address_prefixes = ["10.0.1.0/24"]
    nsg_name         = "nsg-web-dev"
  }
  "subnet-app" = {
    address_prefixes = ["10.0.2.0/24"]
    nsg_name         = "nsg-app-dev"
  }
  "subnet-db" = {
    address_prefixes = ["10.0.3.0/24"]
    nsg_name         = "nsg-db-dev"
  }
}

vms = {
  "vm-web-dev" = {
    vm_size    = "Standard_B1s"
    subnet_key = "subnet-web"
  }
  "vm-app-dev" = {
    vm_size    = "Standard_B1s"
    subnet_key = "subnet-app"
  }
}

storage_account_name = "stglobex"
container_name       = "data-dev"
