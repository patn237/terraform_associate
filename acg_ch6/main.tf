resource "azurerm_resource_group" "test" {
  name     = "rg-test-pn"
  location = var.location
}

module "az_vnet" {
  source              = "./modules/az_vnet/"
  vnet_name           = "vnet-test-pn"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  subnet_name         = "subnet1"
}