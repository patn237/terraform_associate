resource "azurerm_resource_group" "test" {
  name = "rg-test-pn"
  location = "eastus"
}

module "network" {
  source  = "Azure/network/azurerm"
  version = "3.5.0"
  resource_group_name = azurerm_resource_group.test.name

  depends_on = [azurerm_resource_group.test]
}