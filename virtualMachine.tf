resource "azurerm_resource_group" "rgForTF" {
  name = "tfrg"
  location = "West US"
}
resource "azurerm_linux_virtual_machine" "tf-vm1" {
  name                  = "tfVM1"
  location              = "West US"
  resource_group_name   = azurerm_resource_group.rgForTF.name
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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCttlKKjcoeD1le9IhcRdJdZQjI0zBhs2aTyCoM4o39H34eAbtVWgrqJYRVtUqluWlOL14SQ/apFcB/lvU2SR0kK4gXQxatK2Rc3cBGpHX5RajRwTIHEnHSTj9/PdJI8xVcQwHFmwahssZ6cmyvNPoZY/dSEVX69+fqP2+oNQfoUMo9/RIORtQFSjRiFnwpVVBqLtofTuIh2SQUcPbirwkIYkXQ11zrK7tAzL26OSma7DoXlwSfAkcLsjynG08nzQlXnsG9MNbPZPfN3VFG3ytIOSN6P9UI60F95+7SbxSjCyDB34M21UMBPCiYORUGABzs8O1j45VzixcNB3oZfp4wsrLN/ksQI9gGS6kR7UsBzx9xmA7/RqIukthsH/eU69MN/a4gRO8RXEa7SPXz2YytBrac1K+VhzMOMXy/SOlG4K470Lloo7I9wBs7u8nXgZ/CzToF0oXsp8ELxNCV8jouHW3Et8imXRgfP9fFvWGrVg8Zi6/3e4KSbh8XIUBbv1c= ubuntu@ubuntu-IdeaPad-3-15ITL6"
  }
}