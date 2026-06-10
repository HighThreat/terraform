module "rg" {
  source   = "./modules/rg"
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source              = "./modules/network"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  vnet_cidr           = var.vnet_cidr
  subnet_count        = var.subnet_count
  nsg_configs         = var.nsg_configs
  tags                = var.tags
}

module "vm" {
  source              = "./modules/vm"
  resource_group_name = module.rg.rg_name
  location            = module.rg.rg_location
  vm_name             = var.vm_name
  subnet_id           = module.network.subnet_ids[0]
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = file(var.ssh_public_key_path)
  tags                = var.tags
}
