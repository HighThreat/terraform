locals {
  # Prefix with workspace for naming variation
  env_prefix = terraform.workspace
  rg_name    = "rg-globex-${local.env_prefix}"
  vnet_name  = "vnet-globex-${local.env_prefix}"
}

module "rg" {
  source   = "./modules/rg"
  rg_name  = local.rg_name
  location = var.location
  tags     = { Environment = terraform.workspace }
}

module "network" {
  source             = "./modules/network"
  rg_name            = module.rg.rg_name
  location           = module.rg.rg_location
  vnet_name          = local.vnet_name
  vnet_address_space = var.vnet_address_space
  subnets            = var.subnets
  tags               = { Environment = terraform.workspace }
  depends_on         = [module.rg]
}

module "compute" {
  source         = "./modules/compute"
  rg_name        = module.rg.rg_name
  location       = module.rg.rg_location
  
  vms = {
    for k, v in var.vms : k => {
      vm_size   = v.vm_size
      subnet_id = module.network.subnet_ids[v.subnet_key]
    }
  }
  
  admin_username = var.admin_username
  admin_password = var.admin_password
  tags           = { Environment = terraform.workspace }
  depends_on     = [module.network]
}

module "storage" {
  source               = "./modules/storage"
  rg_name              = module.rg.rg_name
  location             = module.rg.rg_location
  storage_account_name = "${var.storage_account_name}${local.env_prefix}"
  container_name       = var.container_name
  tags                 = { Environment = terraform.workspace }
  depends_on           = [module.rg]
}
