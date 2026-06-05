resource_group_name    = "rg-backend-leo"
location               = "France Central"
storage_account_prefix = "leostorage"
container_name         = "leocontainer"
vnet_cidr              = "10.50.0.0/16"
subnet_names           = ["app", "data"]
subnet_cidrs           = ["10.50.1.0/24", "10.50.2.0/24"]
