resource "azurerm_resource_group" "test" {
  name     = "rg-test-pn"
  location = var.location
}

module "linuxservers" {
  source              = "Azure/compute/azurerm"
  resource_group_name = azurerm_resource_group.test.name
  vm_os_simple        = "UbuntuServer"
  public_ip_dns       = ["vm-test-pn-${var.location}"] // change to a unique name per datacenter region
  vnet_subnet_id      = module.network.vnet_subnets[0]
  vm_size             = "Standard_B1ls"
  admin_username      = "adminuser"
  admin_password      = "adminadmin123!"
  enable_ssh_key      = false
  depends_on          = [azurerm_resource_group.test]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.test.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]

  depends_on = [azurerm_resource_group.test]
}