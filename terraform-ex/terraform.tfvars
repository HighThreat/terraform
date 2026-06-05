resource_group_name = "acme-rg"
location            = "France Central"
vnet_cidr           = "10.42.0.0/16"
subnet_names        = ["app", "data"]
subnet_cidrs        = ["10.42.1.0/24", "10.42.2.0/24"]

tags = {
  project     = "acme-terraform-exercise"
  owner       = "student"
  deployed_in = "france-central"
}
