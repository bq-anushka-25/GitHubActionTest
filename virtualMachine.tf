resource "azurerm_linux_virtual_machine" "tf-vm1" {
  name                  = "tfVM1"
  location              = azurerm_resource_group.tf-rg.location
  resource_group_name   = azurerm_resource_group.tf-rg.name
  network_interface_ids = [azurerm_network_interface.tfNic1.id]
  admin_username        = "adminuser"
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}