output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.vnet.id
}

output "vnet_name" {
  value = azurerm_virtual_network.vnet.name
}