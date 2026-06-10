output "vm_public_ip" {
  value       = azurerm_public_ip.pip.ip_address
  description = "The public IP address of the Virtual Machine."
}

output "vm_id" {
  value       = azurerm_linux_virtual_machine.vm.id
  description = "The ID of the Virtual Machine."
}

output "nic_id" {
  value       = azurerm_network_interface.nic.id
  description = "The ID of the Network Interface Card."
}
