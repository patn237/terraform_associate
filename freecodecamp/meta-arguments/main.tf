resource "azurerm_resource_group" "example" {
  name     = "rg-test-pn"
  location = var.location

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnets

  depends_on = [azurerm_virtual_network.example]
}