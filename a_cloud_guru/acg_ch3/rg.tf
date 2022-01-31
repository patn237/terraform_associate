resource "azurerm_resource_group" "rg" {
  name = "rg-test-pn"
  location = var.location
}