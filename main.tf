resource "azurerm_resource_group" "tfresgrp" {
  name     = var.resource_group_name
  location = var.region_name
}

resource "azurerm_virtual_network" "myVnet" {
  name                = var.network_name
  location            = azurerm_resource_group.tfresgrp.location
  resource_group_name = azurerm_resource_group.tfresgrp.name
  address_space       = var.addrspace
}

resource "azurerm_subnet" "subpub" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.myVnet.name
  resource_group_name  = azurerm_resource_group.tfresgrp.name
  address_prefixes     = var.sub_addrspace
}

resource "azurerm_network_interface" "nic_1" {
  resource_group_name = azurerm_resource_group.tfresgrp.name
  location            = azurerm_resource_group.tfresgrp.location
  name                = var.nic_name
  ip_configuration {
    name                          = var.pub_ip_name
    subnet_id                     = azurerm_subnet.subpub.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "windows1" {
  resource_group_name   = azurerm_resource_group.tfresgrp.name
  location              = azurerm_resource_group.tfresgrp.location
  name                  = var.vm_name
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic_1.id]
  storage_os_disk {
    name              = "mydisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "microsoftwindowsdesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-pro"
    version   = "latest"
  }
  os_profile {
    computer_name  = var.admin_user_name
    admin_username = var.admin_user_name
    admin_password = var.password
  }
  os_profile_windows_config {
    provision_vm_agent = true
  }
}

