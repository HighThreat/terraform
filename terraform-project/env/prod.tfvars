location             = "West Europe"
admin_username       = "prodadmin"
admin_password       = "P@ssw0rdGlobexProd!2026"
vnet_address_space   = ["10.1.0.0/16"]

subnets = {
  "subnet-web" = {
    address_prefixes = ["10.1.1.0/24"]
    nsg_name         = "nsg-web-prod"
  }
  "subnet-app" = {
    address_prefixes = ["10.1.2.0/24"]
    nsg_name         = "nsg-app-prod"
  }
  "subnet-db" = {
    address_prefixes = ["10.1.3.0/24"]
    nsg_name         = "nsg-db-prod"
  }
}

vms = {
  "vm-web-prod" = {
    vm_size    = "Standard_B2s"
    subnet_key = "subnet-web"
  }
  "vm-app-prod" = {
    vm_size    = "Standard_B2s"
    subnet_key = "subnet-app"
  }
}

storage_account_name = "stglobex"
container_name       = "data-prod"
