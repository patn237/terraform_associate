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

resource "azurerm_network_security_group" "test" {
  name                = join("-", ["nsg", module.az_vnet.vnet_name])
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  dynamic "security_rule" {
    for_each = var.rules
    content {
      name                       = security_rule.value["name"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      source_port_range          = security_rule.value["source_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_port_range     = security_rule.value["destination_port_range"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id = module.az_vnet.subnet_id
  network_security_group_id = azurerm_network_security_group.test.id
}