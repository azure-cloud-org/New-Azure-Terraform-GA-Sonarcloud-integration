##Basic TF code configuration with sonarcloud integration
# Create a resource group
resource "azurerm_resource_group" "new-sonarcloud-rg" {
  name = "myrg-sonarcloud-new"
  location = "south india"
  
}

##Repeated commented lines to verify configured sonarcloud quality gate rule
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-new-sonarcloud" {
  name                = "myvnet-sonarcloud-new"
  address_space       = ["10.10.0.0/24"]
  location            = azurerm_resource_group.new-sonarcloud-rg.location
  resource_group_name = azurerm_resource_group.new-sonarcloud-rg.name
  
}

# Create Subnet
resource "azurerm_subnet" "new-mysubnet-sonarcloud" {
  name                 = "mysubnet-sonarcloud-integration-new"
  resource_group_name  = azurerm_resource_group.new-sonarcloud-rg.name
  virtual_network_name = azurerm_virtual_network.myvnet-new-sonarcloud.name
  address_prefixes     = ["10.10.0.0/27"]
}

##creating allow all inbound firewall rule to verify sonarcloud SAST detection
resource "azurerm_network_security_group" "new-sonarcloud" {
  name                = "example-nsg"
  location            = azurerm_resource_group.new-sonarcloud-rg.location
  resource_group_name = azurerm_resource_group.new-sonarcloud-rg.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "new-sonarcloud" {
  subnet_id                 = azurerm_subnet.new-mysubnet-sonarcloud.id
  network_security_group_id = azurerm_network_security_group.new-sonarcloud.id
}

