variable "subscription_id" {
        description     = "Subscription ID"
        default         = "0387ddf0-eea2-4265-a843-4f7c61f6ab68"
}

variable "client_id" {
        description     = "Client ID"
        default         = ""
}

variable "client_secret" {
        description     = "Client Secret"
        default         = ""
}

variable "tenant_id" {
        description     = "tenant ID"
        default         = ""
}

variable "rgname" {
        description     = "Resource Group Name"
        default         = "test1234ak282"
}

variable "location" {
        description     = "Azure Region"
        default         = "East US"
}

variable "vnet" {
        description     = "Virtual Network name"
        default         = "vnet"
}

variable "snet" {
        description     = "Subnet Name"
        default         = ""
}

variable "nsgname" {
        description     = "Network Security Group Name"
        default         = ""
}

variable "vm_name" {
        description     = "Virtual Machine Name"
        default         = ""
}

variable "vm_size" {
        description     = "Vitrual Machine Size"
        default         = "Standard_DS1_v2"
}

variable "numofvm" {
        description     = "number of vm instances"
        default         = "4"
}

variable "saname" {
	description	= "Storage Account Name"
	default		= "testsa"
}

variable "sacname" {
	description	= "Storage Account Container Name"
	default		= "testcontainer"
}

variable "ssh_keys" {
        description     = "User SSH Key"
        default         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnQ0ZHum2SfKYuweGCpna673d7i0kD63IQ75pYEAVRdwr6FkkZ0y6QuzW9T0JMskcaL8jUAQwAUSrP8Gfp7gzLX8gdn9P1CB+v4CmPhgpQcx5prMXLv/ynYEUJJ8793YaIOJ2ie7+3dj5eZNqXvQKeqGQm4s32Rnrad7T9pFA5zM4d8iZUyV68jDIRbi9q7kfTh3ZP4NjiIJCftuSI0mjTkjy2KLk3a/o9JryB2OlqEaVdH/92UytGcipp7odhqbRgZMtpfnHBiz/TtMMlmNdIjodKZCTCHcpKMeP35X/bL5ZGQ5F4WyDbrZXqUapYWaBQ/Wnew9q2q0BOCutyxT4H user@DESKTOP-167C00F"
}
