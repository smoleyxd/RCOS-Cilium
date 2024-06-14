# Configure the Azure provider


data "azurerm_resource_group" "rg" {
  name     = "RCOS-Cilium_group"
}

resource "azurerm_virtual_network" "vnet"{
    name = "testVnet"
    address_space = ["10.0.0.0/16"]
    location = "eastus"
        resource_group_name = data.azurerm_resource_group.rg.name
}


