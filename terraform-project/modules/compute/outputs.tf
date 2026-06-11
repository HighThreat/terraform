output "vm_names" {
  value       = [for k, v in azurerm_linux_virtual_machine.vm : v.name]
  description = "Names of the created VMs"
}

output "public_ips" {
  value       = [for k, v in azurerm_linux_virtual_machine.vm : azurerm_public_ip.pip[k].ip_address]
  description = "Public IPs of the created VMs"
}
