# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
}

# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "resource_group" {
  name     = "${var.prefix}-ResourceGroup"
  location = "Japan East"

  tags {
    environment = "Test"
  }
}

# Create virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.prefix}-Vnet"
  address_space       = ["192.168.0.0/16"]
  location            = "Japan East"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  tags {
    environment = "Tesst"
  }
}

# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-Subnet"
  resource_group_name  = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.virtual_network.name}"
  address_prefix       = "192.168.0.0/24"
}

# Create public IPs
resource "azurerm_public_ip" "publicip" {
  name                         = "${var.prefix}-PublicIP"
  location                     = "Japan East"
  resource_group_name          = "${azurerm_resource_group.resource_group.name}"
  public_ip_address_allocation = "dynamic"

  tags {
    environment = "Test"
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "security_group" {
  name                = "${var.prefix}-NetworkSecurityGroup"
  location            = "Japan East"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags {
    environment = "Test"
  }
}

# Create network interface
resource "azurerm_network_interface" "network_nic" {
  name                      = "${var.prefix}-NIC"
  location                  = "Japan East"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  network_security_group_id = "${azurerm_network_security_group.security_group.id}"

  ip_configuration {
    name                          = "NicConfiguration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.publicip.id}"
  }

  tags {
    environment = "Test"
  }
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = "${azurerm_resource_group.resource_group.name}"
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "storage_account" {
  name                     = "diag${random_id.randomId.hex}"
  resource_group_name      = "${azurerm_resource_group.resource_group.name}"
  location                 = "Japan East"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "Test"
  }
}

# Create virtual machine
resource "azurerm_virtual_machine" "virtual_machine" {
  name                  = "${var.prefix}-VM"
  location              = "Japan East"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${azurerm_network_interface.network_nic.id}"]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "<USER_NAME>>"
    admin_username = "<USER_NAME>"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/<USER_NAME>/.ssh/authorized_keys"
      key_data = "<SSHE_PUBLIC_KEY>"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.storage_account.primary_blob_endpoint}"
  }

  tags {
    environment = "Test"
  }
}
