# Cilium Onboarding / Pre-requisites
**Preface:**  
This markdown file should allow you to quickly and effectively 

**Cilium:**  
Cilium is a networking plugin for Kubernetes, designed to provide efficient networking and security services. It operates at the Linux kernel level, leveraging eBPF (extended Berkeley Packet Filter) technology to handle network traffic. Cilium offers features like network policy enforcement, load balancing, and observability, making it a powerful solution for containerized environments.

**Kubernetes:**  
Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications. It provides a framework for deploying and managing applications across a cluster of machines, abstracting away the underlying infrastructure complexity and enabling developers to focus on building and running their applications.


**eBPF:**  
eBPF, or extended Berkeley Packet Filter, is a technology in the Linux kernel that allows for programmatically handling network packets and system events at runtime, without needing to modify the kernel itself. It's commonly used for tasks like network monitoring, security enforcement, and performance optimization. In the context of Kubernetes, eBPF is often used by networking plugins like Cilium to efficiently handle network traffic and enforce policies at the kernel level.


**CNI:**  
CNI stands for Container Network Interface. It's a specification in the Kubernetes ecosystem that defines how networking is configured for containerized workloads. Essentially, CNIs enable different networking plugins, like Cilium, to integrate with Kubernetes clusters, providing network connectivity and services to containers running on the cluster.

