provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg_myresource!!"  # Mistake: Invalid characters (!!), should follow alphanumeric, underscore, or hyphen conventions.
  location = "northcentralus"   # Mistake: Invalid location, should be one of: eastus, westus, or centralus.
}

resource "azurerm_virtual_machine" "example" {
  name                  = "my-vm"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_DS3_v2"  # Mistake: Invalid size, should be one of: Standard_DS1_v2 or Standard_DS2_v2.

  network_interface_ids = [azurerm_network_interface.example.id]
  vm_os_type            = "Linux"

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "P@ssword1234!"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_network_security_rule" "example" {
  name                        = "allow_ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.0.0/8"
  destination_address_prefix  = "10.1.0.0/16"
  ip_range                    = "192.168.1.0/33"  # Mistake: Invalid CIDR range, should follow valid CIDR format.
  network_security_group_name = azurerm_network_security_group.example.name
}
