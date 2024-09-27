# Tuning paremeters
In order to create the test suite we have to be able to enable or disable certain tuning parameters
The goal is to be able to do this in a github action.
See for the proposed action
Though first we have to change the parameters through a script
See "SCRIPT" for the script

See https://docs.cilium.io/en/stable/operations/performance/tuning/ for the tuning parameters to change.
We will only be modifiying:
BIG TCP
Bypassing iptables Tracking
MTU
Bandwidth congestion
BBR congestion
XDP Acceleration
eBPF Map Sizing

We do not have plans to enable hubble.
We will be using "Kernel" for all of our testing

# Process

