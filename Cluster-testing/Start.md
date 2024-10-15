
# CNI Performance Testing: Calico vs Cilium

## Objective

This semester, the goal is to deploy multiple clusters using different CNI’s such as **Cilium** and **Calico** to identify the pros and cons of each CNI. The performance data will be displayed using Python libraries to analyze any potential differences in **Cilium** vs **Calico**.

## Notes

Ensure that you are on the **jon-onboarding** branch before starting the deployment.

---

## Setup Guide

### 10/8 Week - Installed Calico

### 1. Install Kind to create multiple Kubernetes clusters locally using Docker.
- Install **Kind** using the following command:
    ```bash
    brew install kind
    ```

### 2. Step-by-Step Guide to Use Docker with Kind

1. **Navigate to the project folder**:  
    ```bash
    cd cluster-testing
    ```

2. **Check Docker Containers** (it should be empty):
    ```bash
    docker ps
    ```

### 3. Create a Multi-Node Cluster

#### A. Create a Cluster with **Calico CNI**:

1. **Create a Kind cluster** for testing with Calico:
    ```bash
    kind create cluster --name calico-cluster
    ```

2. **Install Calico as the CNI**:
    ```bash
    kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    ```

3. **Verify Calico Installation**:
    ```bash
    kubectl get pods -n kube-system
    ```

    ![Calico:](/Testing/Calico-start.png)

#### B. Create a Cluster with **Cilium CNI**:

1. **Create another Kind cluster** for testing with Cilium:
    ```bash
    kind create cluster --name cilium-cluster
    ```

2. **Install Cilium using Helm**:
    ```bash
    helm repo add cilium https://helm.cilium.io/
    helm install cilium cilium/cilium --version 1.12.0 --namespace kube-system
    ```

3. **Verify Cilium Installation**:
    ```bash
    kubectl get pods -n kube-system
    ```

    ![Cilium:](/Testing/Cilium.png)

4. **Check Docker Containers** after creating the clusters:
    ```bash
    docker ps
    ```
    ![Docker Containers:](/Testing/Docker-check.png)

---

## Metrics Collection

### 1. **Network Performance**
- **Throughput and Latency**: Measure raw data transfer speeds and the delay between packet transmissions across the cluster nodes.
- **Packet Loss and Jitter**: Test for packet loss and variation in latency during heavy loads or under specific traffic patterns.

---



