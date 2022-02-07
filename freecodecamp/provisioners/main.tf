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

resource "azurerm_public_ip" "test" {
  name                = "pip-vm-test-pn"
  resource_group_name = azurerm_resource_group.test.name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "test" {
  name                = "nic-vm-test-pn"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name

  ip_configuration {
    name                          = "external"
    subnet_id                     = module.az_vnet.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.test.id
  }
}

data "template_file" "cloud_init" {
  template = file("./cloud-init.yml")
}

resource "azurerm_linux_virtual_machine" "test" {
  name = "vm-test-pn"
  resource_group_name = azurerm_resource_group.test.name
  location = var.location
  size = "Standard_B1ls"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.test.id]
  user_data = base64encode(data.template_file.cloud_init.rendered)
  provisioner "file" {
    content = "mars"
    destination = "/home/adminuser/barsoon.txt"
    connection {
      type = "ssh"
      user = "adminuser"
      host = "${azurerm_linux_virtual_machine.test.public_ip_address}"
      private_key = "${file("./terraform")}"
    }
  }

  admin_ssh_key {
    username = "adminuser"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "az vm list"
  }
  depends_on = [azurerm_linux_virtual_machine.test]
}