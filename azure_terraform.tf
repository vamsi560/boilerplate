# Incorrect location
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "invalidlocation"  # Should be one of: eastus, westus, or centralus
}

# Incorrect size
resource "azurerm_virtual_machine" "example" {
  name                = "example-vm"
  resource_group_name = "example-resources"
  location            = "eastus"
  size                = "Invalid_Size"  # Should be one of: Standard_DS1_v2 or Standard_DS2_v2
}

# Invalid resource group name
resource "azurerm_storage_account" "example" {
  name                     = "examplestoracc"  # Should follow alphanumeric, underscore, or hyphen conventions
  resource_group_name      = "example-resources"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Invalid IP range
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  resource_group_name = "example-resources"
  location            = "eastus"
  
  security_rule {
    name                   = "example-rule"
    priority               = 1000
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "*"
    source_port_range      = "*"
    destination_port_range = "*"
    source_address_prefix  = "10.0.0.0/33"  # Should be a valid CIDR range
    destination_address_prefix = "*"
  }
}
