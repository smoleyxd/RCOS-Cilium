# Tuning paremeters
In order to create the test suite we have to be able to enable or disable certain tuning parameters
The goal is to be able to do this in a github action.
See for the proposed action
Though first we have to change the parameters through a script
See "SCRIPT" for the script

See https://docs.cilium.io/en/stable/operations/performance/tuning/ for the tuning parameters to change.
We will only be modifiying:
BIG TCP
MTU
BBR Congestion Control for Pods
XDP Acceleration
eBPF Map Sizing
Hubble Obserbability
Bandwith Manager
Netkit Device Mode
Bypassing Iptables Tracking

We will be using "Kernel" for all of our testing

# Expected Results
BIG TCP
Improved throughput and latency
Increased CPU utilization (more CPU strain) 

MTU
Increased throughput
Increased Jitter and Data corruption / Packets Dropped
Increased CPU utilization

BBR Congestion Control for Pods
Increased bandwidth 
Improved latency
Increased CPU utilization

XDP Acceleration
Better latency and decrease in network jitter

eBPF Map Sizing
Better scaliabiklity
Increased Memory cost

Hubble Obserbability
Increased network performance
Decreased CPU strain

Bandwith Manager
Improved latency and throughput
Increased CPU strain

Netkit Device Mode
Significant latency reductions
Improved throughput

Bypassing Iptables Tracking
Improvements in latency and throughput
Decrease in network jitter


# Process
Using Golang, a script will run our Cilium infrastructure for varying intervals of times. This script will be ran for each tuning parameters and allows us to mimic usage of contianerized applications for short-term and long-term capabilities. Additionally, through the use of Prometheus and Grafana we can gather and visualize the network and CPU perfomance impact each tuning parameters has. We will then automate this testing process using github actions to test on a daily/weekly schedule. 

# Results
To Be Determined...
