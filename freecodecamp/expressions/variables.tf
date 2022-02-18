variable "location" {
  type    = string
  default = "eastus"
}

variable "rules" {
  type = list(object({
    name                       = string
    protocol                   = string
    access                     = string
    priority                   = number
    direction                  = string
    source_port_range          = string
    source_address_prefix      = string
    destination_port_range     = number
    destination_address_prefix = string
  }))
  default = [{
    access                     = "Allow"
    destination_port_range     = 80
    destination_address_prefix = "*"
    direction                  = "Inbound"
    name                       = "http-inbound"
    priority                   = 100
    protocol                   = "Tcp"
    source_address_prefix      = "*"
    source_port_range          = "*"
    },
    {
      access                     = "Allow"
      destination_port_range     = 22
      destination_address_prefix = "*"
      direction                  = "Inbound"
      name                       = "ssh-inbound"
      priority                   = 500
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
  }]
}