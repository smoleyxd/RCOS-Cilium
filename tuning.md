# Tuning paremeters
In order to create the test suite we have to be able to enable or disable certain tuning parameters
The goal is to be able to do this in a github action.
See for the proposed action
Though first we have to change the parameters through a script
See "SCRIPT" for the script

See https://docs.cilium.io/en/stable/operations/performance/tuning/ for the tuning parameters to change.
We will only be modifiying:
BIG TCP
Bypassing Iptables Tracking
MTU
Bandwidth congestion
BBR Congestion Control for Pods
XDP Acceleration
eBPF Map Sizing
Hubble Obserbability
Bandwith manager
Netkit Device Mode

We will be using "Kernel" for all of our testing

# Expected Results
BIG TCP: A enlarged TCP packet utilized to reduce transmission overhead of TCP packets.
Here we expect to see improved throughput and latency, while CPU utilization increase. 

MTU
Increases throughput
Increased Jitter and Data corruption/ Packet Dropped

Bandwidth Congestion
BBR Congestion Control for Pods
XDP Acceleration
eBPF Map Sizing
Hubble Obserbability
Bandwith manager
Netkit Device Mode

# Process
Using Golang, a script will run our Cilium infrastructure for varying intervals of times. This script will be ran for each tuning parameters and allows us to mimic usage of contianerized applications for short-term and long-term capabilities. Additionally, through the use of Prometheus and Grafana we can gather and visualize the network and CPU perfomance impact each tuning parameters has. We will then automate this testing process using github actions to test on a daily/weekly schedule. 

# Results
To Be Determined...
