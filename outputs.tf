# outputs.tf

output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}


# Output the grafana url for usability
output "grafana_url" {
  value = azurerm_dashboard_grafana.graf.endpoint
}
