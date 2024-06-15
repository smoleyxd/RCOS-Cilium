data "azurerm_resource_group" "rg" {
    name = "RCOS-Cilium_group"
    location = "eastus"
}

resource "azurerm_virtual_network" "vnet"{
    name = "test-vnet"
    address_space = ["10.0.0.0/16"]
    location = data.azurerm_resource_group.rg.location
        resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_kubernetes_cluster" "default" {
    name = "test-cilium-aks"
    location = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
    dns_prefix = "test-cilum-k8s"
    kubernetes_version = "1.29.4"
    default_node_pool{
        name = "default"
        node_count = 1
        vm_size = "Standard_A2_v2"
        os_disk_size_gb = 30
    }
    service_principal{
        client_id = var.CLIENT_ID
        client_secret = var.CLIENT_SECRET
    }
    role_based_access_control_enabled = true
    identity{
        type = "SystemAssigned"
    }
    network_profile {
        network_plugin = "azure"
        ebpf_data_plane = "cilium"
    }
}
