terraform {
  required_providers {
    azurerm={
        source = "Hashicorp/azurerm"
        version = "~>3.0.2"
    }
  }
}

provider "azurerm" {
    features {}
  
}

resource "azurerm_resource_group" "rg" {
  name     = "test-rg"
  location = "westus"
}

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.resource_group_name
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_space]
}

module "vnet" {
  source               = "../terrr"
  resource_group_name  = "test-rg"
  location             = "westus"
  vnet_name            = "new-vnet"
  vnet_address_space   = "10.10.0.0/16"
  subnet_name          = "subnet01"
  subnet_address_space = "10.10.10.0/24"
}