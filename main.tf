provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg_demo" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_demo.location
  resource_group_name = azurerm_resource_group.rg_demo.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg_demo.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}
