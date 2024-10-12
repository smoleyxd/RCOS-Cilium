#!/bin/bash

# Load eBPF program
clang -O2 -target bpf -c abnormal_traffic.c -o abnormal_traffic.o
sudo bpftool prog load abnormal_traffic.o /sys/fs/bpf/abnormal_traffic
sudo bpftool net attach xdpdrv pinned /sys/fs/bpf/abnormal_traffic dev eth0

