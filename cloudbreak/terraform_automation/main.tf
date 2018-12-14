provider "azurerm" {
        subscription_id = "${var.subscription_id}"
        client_id       = "${var.client_id}"
        client_secret   = "${var.client_secret}"
        tenant_id       = "${var.tenant_id}"
}

# Create a Resource Group
resource "azurerm_resource_group" "rg" {
        name                            = "${var.rgname}"
        location                        = "${var.location}"

        tags {
                environment             = "test"
        }
}

resource "azurerm_management_lock" "rg_lock" {
        name                            = "resource-group-lock"
        scope                           = "${azurerm_resource_group.rg.id}"
        lock_level                      = "CanNotDelete"
        notes                           = "This Resource Group can not be deleted"
}

#Create a Virtual Network
resource "azurerm_virtual_network" "my_vnet"{
        name                            = "${var.vnet}"
        address_space                   = ["10.0.0.0/16"]
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"

        tags {
                environment             = "test"
        }
}

# Create first subnets
resource "azurerm_subnet" "mysubnet"{
        name                            = "mysubnet0"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        virtual_network_name            = "${azurerm_virtual_network.my_vnet.name}"
        address_prefix                  = "10.0.1.0/24"
#	network_security_group_id 	= "${azurerm_network_security_group.mynsg.id}"

}

# Create second subnets
resource "azurerm_subnet" "mysubnet1"{
        name                            = "mysubnet1"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        virtual_network_name            = "${azurerm_virtual_network.my_vnet.name}"
        address_prefix                  = "10.0.2.0/24"
#	network_security_group_id       = "${azurerm_network_security_group.mynsg1.id}"
}
# Create third subnets
resource "azurerm_subnet" "mysubnet2"{
        name                            = "mysubnet2"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        virtual_network_name            = "${azurerm_virtual_network.my_vnet.name}"
        address_prefix                  = "10.0.3.0/24"
#	network_security_group_id       = "${azurerm_network_security_group.mynsg2.id}"
}
# Create fourth subnets
resource "azurerm_subnet" "mysubnet3"{
        name                            = "mysubnet3"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        virtual_network_name            = "${azurerm_virtual_network.my_vnet.name}"
        address_prefix                  = "10.0.4.0/24"
#	network_security_group_id       = "${azurerm_network_security_group.mynsg2.id}"
}


# Create first Network Security group
resource "azurerm_network_security_group" "mynsg" {
        name                            = "mynsg${count.index}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"

        security_rule {
                name                            = "ssh"
                priority                        = 1001
                direction                       = "Inbound"
                access                          = "Allow"
                protocol                        = "tcp"
                source_port_range               = "*"
                destination_port_range          = "22"
                source_address_prefix           = "*"
                destination_address_prefix      = "*"
        }

        tags {
                environment             = "test"
        }
}

# Create second Network Security group
resource "azurerm_network_security_group" "mynsg1" {
        name                            = "mynsg${count.index}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        
        security_rule {                         
                name                            = "ssh"
                priority                        = 1001
                direction                       = "Inbound"
                access                          = "Allow"
                protocol                        = "tcp"
                source_port_range               = "*"
                destination_port_range          = "22"
                source_address_prefix           = "*"
                destination_address_prefix      = "*"
        }
        
        tags {  
                environment             = "test"
        }
}

# Create third Network Security group
resource "azurerm_network_security_group" "mynsg2" {
        name                            = "mynsg${count.index}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        
        security_rule {                         
                name                            = "ssh"
                priority                        = 1001
                direction                       = "Inbound"
                access                          = "Allow"
                protocol                        = "tcp"
                source_port_range               = "*"
                destination_port_range          = "22"
                source_address_prefix           = "*"
                destination_address_prefix      = "*"
        }
        
        tags {  
                environment             = "test"
        }
}

# Assign security groups to subnets
resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = "${azurerm_subnet.mysubnet.id}"
  network_security_group_id = "${azurerm_network_security_group.mynsg.id}"
}

resource "azurerm_subnet_network_security_group_association" "test1" {
  subnet_id                 = "${azurerm_subnet.mysubnet1.id}"
  network_security_group_id = "${azurerm_network_security_group.mynsg1.id}"
}

resource "azurerm_subnet_network_security_group_association" "test2" {
  subnet_id                 = "${azurerm_subnet.mysubnet2.id}"
  network_security_group_id = "${azurerm_network_security_group.mynsg2.id}"
}

resource "azurerm_subnet_network_security_group_association" "test3" {
  subnet_id                 = "${azurerm_subnet.mysubnet2.id}"
  network_security_group_id = "${azurerm_network_security_group.mynsg2.id}"
}
# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = "${azurerm_resource_group.rg.name}"
    }

    byte_length = 8
}
# Create first Storage Account
resource "azurerm_storage_account" "test" {
        name                            = "${var.saname}${random_id.randomId.hex}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        account_tier                    = "Standard"
        account_replication_type        = "LRS"
}

#Create a storage container
resource "azurerm_storage_container" "container" {
        name                            = "${var.sacname}${random_id.randomId.hex}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
       	storage_account_name            = "${azurerm_storage_account.test.name}"
       	container_access_type           = "private"
}

# Create second Storage Account
resource "azurerm_storage_account" "test22" {
        name                            = "test2${random_id.randomId.hex}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        account_tier                    = "Standard"
        account_replication_type        = "LRS"
}

# Create four Network Interface
resource"azurerm_network_interface" "testnic" {
        name                            = "test${format("%02d",count.index+1)}-nic"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
#       network_security_group_id       = "${azurerm_network_security_group.mynsg.id}"
        count                           = "${var.numofvm}"

        ip_configuration {
                name                            = "config_ip"
                subnet_id                       = "${azurerm_subnet.mysubnet1.id}"
                private_ip_address_allocation   = "dynamic"
        }
}

# Create four Virtual Machines
resource "azurerm_virtual_machine" "myvm" {
        name                            = "myvm${format("%02d",count.index+1)}"
        location                        = "${var.location}"
        resource_group_name             = "${azurerm_resource_group.rg.name}"
        network_interface_ids           = ["${element(azurerm_network_interface.testnic.*.id, count.index)}"]
        vm_size                         = "${var.vm_size}"
        count                           = "${var.numofvm}"

        storage_os_disk {               
                name                    = "disk${format("%02d",count.index+1)}"
                caching                 = "ReadWrite"
                create_option           = "FromImage"
                managed_disk_type       = "Premium_LRS"
        }

        storage_image_reference {
                publisher               = "openLogic"
                offer                   = "CentOS"
                sku                     = "7.5"
                version                 = "latest"
        }

        os_profile {
                computer_name           = "myvm${format("%02d",count.index+1)}"
                admin_username          = "azureuser"
        }

        os_profile_linux_config {
                disable_password_authentication = true
                ssh_keys {
                        path            = "/home/azureuser/.ssh/authorized_keys"
                        key_data        = "${var.ssh_keys}"
                }
        }

        tags {
                environment             = "test"
        }
}