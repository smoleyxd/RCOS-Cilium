# main.tf

data "azurerm_resource_group" "rg" {
  name = "RCOS-Cilium_group"
}

data "azurerm_subscription" "current"{}
resource "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  address_space       = ["10.0.0.0/8"]
  location            = var.RESOURCE_GROUP_LOCATION
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "test-subnet"
  address_prefixes     = ["10.240.0.0/16"]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "podsubnet" {
  name                 = "pod-subnet"
  address_prefixes     = ["10.241.0.0/16"]
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}



resource "azurerm_monitor_workspace" "prom"{
    name = "prom-test"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = var.RESOURCE_GROUP_LOCATION
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

 
# Output the grafana url for usability
output "grafana_url" {
  value = azurerm_dashboard_grafana.graf.endpoint
}

resource "azurerm_monitor_data_collection_endpoint" "dce"{ #TODO: Move to outputs.tf
    name = "MSProm-${azurerm_monitor_workspace.prom.location}-${azurerm_kubernetes_cluster.default.name}"
    resource_group_name = data.azurerm_resource_group.rg.name
    location = var.RESOURCE_GROUP_LOCATION
    kind = "Linux"
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

resource "azurerm_monitor_alert_prometheus_rule_group" "node_recording_rules_rule_group" {
  name                = "NodeRecordingRulesRuleGroup-${azurerm_kubernetes_cluster.default.name}"
  location            = var.RESOURCE_GROUP_LOCATION
  resource_group_name = data.azurerm_resource_group.rg.name
  cluster_name        = azurerm_kubernetes_cluster.default.name
  description         = "Node Recording Rules Rule Group"
  rule_group_enabled  = true
  interval            = "PT1M"
  scopes              = [azurerm_monitor_workspace.prom.id,azurerm_kubernetes_cluster.default.id]

  rule {
    enabled    = true
    record     = "instance:node_num_cpu:sum"
    expression = <<EOF
count without (cpu, mode) (  node_cpu_seconds_total{job="node",mode="idle"})
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_cpu_utilisation:rate5m"
    expression = <<EOF
1 - avg without (cpu) (  sum without (mode) (rate(node_cpu_seconds_total{job="node", mode=~"idle|iowait|steal"}[5m])))
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_load1_per_cpu:ratio"
    expression = <<EOF
(  node_load1{job="node"}/  instance:node_num_cpu:sum{job="node"})
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_memory_utilisation:ratio"
    expression = <<EOF
1 - (  (    node_memory_MemAvailable_bytes{job="node"}    or    (      node_memory_Buffers_bytes{job="node"}      +      node_memory_Cached_bytes{job="node"}      +      node_memory_MemFree_bytes{job="node"}      +      node_memory_Slab_bytes{job="node"}    )  )/  node_memory_MemTotal_bytes{job="node"})
EOF
  }
  rule {
    enabled = true

    record     = "instance:node_vmstat_pgmajfault:rate5m"
    expression = <<EOF
rate(node_vmstat_pgmajfault{job="node"}[5m])
EOF
  }
  rule {
    enabled    = true
    record     = "instance_device:node_disk_io_time_seconds:rate5m"
    expression = <<EOF
rate(node_disk_io_time_seconds_total{job="node", device!=""}[5m])
EOF
  }
  rule {
    enabled    = true
    record     = "instance_device:node_disk_io_time_weighted_seconds:rate5m"
    expression = <<EOF
rate(node_disk_io_time_weighted_seconds_total{job="node", device!=""}[5m])
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_network_receive_bytes_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_receive_bytes_total{job="node", device!="lo"}[5m]))
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_network_transmit_bytes_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_transmit_bytes_total{job="node", device!="lo"}[5m]))
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_network_receive_drop_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_receive_drop_total{job="node", device!="lo"}[5m]))
EOF
  }
  rule {
    enabled    = true
    record     = "instance:node_network_transmit_drop_excluding_lo:rate5m"
    expression = <<EOF
sum without (device) (  rate(node_network_transmit_drop_total{job="node", device!="lo"}[5m]))
EOF
  }
}


resource "azurerm_kubernetes_cluster" "default" {
  name                = "test-cilium-aks"
  location            = var.RESOURCE_GROUP_LOCATION
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "test-cilium-k8s"
  kubernetes_version  = "1.30"
  identity{
    type = "SystemAssigned"
  }
  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_B2s"
    os_disk_size_gb = 30
    vnet_subnet_id  = azurerm_subnet.subnet.id
  }

  role_based_access_control_enabled = true

  network_profile {
    network_plugin = "azure"
  }
  monitor_metrics{
    annotations_allowed = null
    labels_allowed = null
  }
}

