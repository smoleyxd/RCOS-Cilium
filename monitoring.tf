
resource "azurerm_monitor_workspace" "prom" {
  name                = "prom-test"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.RESOURCE_GROUP_LOCATION
}
resource "azurerm_dashboard_grafana" "graf" {
  name                              = "graf-test1"
  resource_group_name               = data.azurerm_resource_group.rg.name
  location                          = data.azurerm_resource_group.rg.location
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = false
  public_network_access_enabled     = true
  identity {
    type = "SystemAssigned"
  }
  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.prom.id
  }
}

resource "azurerm_role_assignment" "grafana" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = "Monitoring Reader"
  principal_id         = azurerm_dashboard_grafana.graf.identity[0].principal_id
}

resource "azurerm_monitor_data_collection_endpoint" "dce" { #TODO: Move to outputs.tf
  name                = "MSProm-${azurerm_monitor_workspace.prom.location}-${azurerm_kubernetes_cluster.default.name}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.RESOURCE_GROUP_LOCATION
  kind                = "Linux"
}

resource "azurerm_monitor_data_collection_rule" "dcr" { #TODO: Move to outputs.tf or elsewhere
  name                        = "MSProm-${azurerm_monitor_workspace.prom.location}-${azurerm_kubernetes_cluster.default.name}"
  resource_group_name         = data.azurerm_resource_group.rg.name
  location                    = azurerm_monitor_workspace.prom.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.dce.id
  kind                        = "Linux"
  destinations {
    monitor_account {
      monitor_account_id = azurerm_monitor_workspace.prom.id
      name               = "MonitoringAccount1"
    }
  }
  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = ["MonitoringAccount1"]
  }
  data_sources {
    prometheus_forwarder {
      streams = ["Microsoft-PrometheusMetrics"]
      name    = "PrometheusDataSource"
    }
  }
  description = "DCR for Azure Monitor Metrics Profile (Managed Prometheus)"
  depends_on = [
    azurerm_monitor_data_collection_endpoint.dce
  ]
}

resource "azurerm_monitor_data_collection_rule_association" "dcra" {
  name                    = "MSProm-${azurerm_monitor_workspace.prom.location}-${azurerm_kubernetes_cluster.default.name}"
  target_resource_id      = azurerm_kubernetes_cluster.default.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.dcr.id
  description             = "Association of data collection rule. Deleting this association will break the data collection for this AKS Cluster."
  depends_on = [
    azurerm_monitor_data_collection_rule.dcr
  ]
}


