resource "azurerm_virtual_network" "Vnet1" {
  name                = "tf-Vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "West US"
  resource_group_name = azurerm_resource_group.rgForTF.name
}

resource "azurerm_subnet" "tf-subnet" {
  name                 = "tf-VnetSubnet1"
  resource_group_name  = azurerm_resource_group.rgForTF.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "tfPublicIp" {
  name                = "tfPublicIP1"
  location            = "West US"
  resource_group_name = azurerm_resource_group.rgForTF.name
  allocation_method   = "Static"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "tfNic1" {
  name                = "vm1-nic"
  location            = "West US"
  resource_group_name = azurerm_resource_group.rgForTF.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.tf-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tfPublicIp.id
  }
}
resource "azurerm_network_security_group" "tf-nsg" {
  name                = "acceptanceSSH"
  location            = "West US"
  resource_group_name = azurerm_resource_group.rgForTF.name

  security_rule {
    name                       = "sgRule1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.tfNic1.id
  network_security_group_id = azurerm_network_security_group.tf-nsg.id
}
