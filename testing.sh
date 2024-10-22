#!/bin/bash

# To run the following script use the following command:
# bash testing.sh $Tuning Parameter$

# Predefined array of tuning paramters
tuningparameters=(
    "cilium-base"
    "cilium-bandwidth"
    "cilium-bbr-congestion"
    "cilium-bigtcp"
    "cilium-hubble-off"
    "cilium-iptables-bypass"
    "cilium-netkit"
    "cilium-xdp"
)

VALIDPARAMETER=0

if [[ $# -eq 0 ]]; then 
    printf "ERROR: 0 arguments passed to testing.sh\n"
    printf "Please specify one of the following tuning parameter to deploy:\n"
    printf "\tcilium-base\n\tcilium-bandwidth\n\tcilium-bbr-congestion\n\tcilium-bigtcp\n\tcilium-hubble-off\n\tcilium-iptables-bypass\n\tcilium-netkit\n\tcilium-xdp\n"
        
else 
    for parameter in ${tuningparameters[@]}; do
        if [[ "$1" ==  "$parameter" ]]; then
            VALIDPARAMETER=1

            printf "Cilium Testing Suite Script\n"
            printf "Intialize Infrastructure\n"
            terraform init

            printf "Plan and Apply the Construction of Infrastructure\n"
            terraform apply -target="helm_release.$1" -target="azurerm_monitor_alert_prometheus_rule_group.node_recording_rules_rule_group" -target="azurerm_virtual_network.vnet" -target="azurerm_subnet.subnet" -target="azurerm_subnet.podsubnet" -target="azurerm_kubernetes_cluster.default" -target="azurerm_monitor_workspace.prom" -target="azurerm_dashboard_grafana.graf" -target="azurerm_role_assignment.grafana" -target="azurerm_monitor_data_collection_endpoint.dce" -target="azurerm_monitor_data_collection_rule.dcr" -target="azurerm_monitor_data_collection_rule_association.dcra"
            break
        fi
    done

    if [[ $VALIDPARAMETER -eq 0 ]]; then 
        printf "ERROR: Unknown tuning parameter passed to testing.sh\n"
        printf "Please specify one of the following tuning parameter to deploy:\n"
        printf "\tcilium-base\n\tcilium-bandwidth\n\tcilium-bbr-congestion\n\tcilium-bigtcp\n\tcilium-hubble-off\n\tcilium-iptables-bypass\n\tcilium-netkit\n\tcilium-xdp\n"
    fi
fi
