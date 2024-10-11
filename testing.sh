#!/bin/bash

tuningparameters=(
    "cilium_base"
    "cilium_bandwidth"
    "cilium_bbr_congestion"
    "cilium_bigtcp"
    "cilium_hubble_off"
    "cilium_iptables_bypass"
    "cilium_netkit"
    "cilium_xdp"
)

VALIDPARAMETER=0

if [[ $# -eq 0 ]]; then 
    printf "ERROR: 0 arguments passed to testing.sh\n"
    printf "Please specify one of the following tuning parameter to deploy:\n"
    printf "\tcilium_base\n\tcilium_bandwidth\n\tcilium_bbr_congestion\n\tcilium_bigtcp\n\tcilium_hubble_off\n\tcilium_iptables_bypass\n\tcilium_netkit\n\tcilium_xdp\n"
        
else 
    for parameter in ${tuningparameters[@]}; do
        if [[ "$1" ==  "$parameter" ]]; then
            VALIDPARAMETER=1

            printf "Cilium Testing Suite Script\n"
            printf "Intialize Infrastructure\n"
            terraform init

            printf "Plan and Apply the Construction of Infrastructure\n"
            # terraform plan -target="helm_release.$1" -target="azurerm_monitor_alert_prometheus_rule_group.node_recording_rules_rule_group" 
            break
        fi
    done

    if [[ $VALIDPARAMETER -eq 0 ]]; then 
        printf "ERROR: Unknown tuning parameter passed to testing.sh\n"
        printf "Please specify one of the following tuning parameter to deploy:\n"
        printf "\tcilium_base\n\tcilium_bandwidth\n\tcilium_bbr_congestion\n\tcilium_bigtcp\n\tcilium_hubble_off\n\tcilium_iptables_bypass\n\tcilium_netkit\n\tcilium_xdp\n"
    fi
fi

