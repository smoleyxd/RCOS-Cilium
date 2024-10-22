
# Network Performance Testing with Cilium and Calico

## **Overview**
This guide provides steps to measure **throughput** and **latency** across cluster nodes using **Cilium** and **Calico** as CNIs. We will deploy test pods using `iperf3` to measure data transfer speeds and the delay between packet transmissions.

---

iperf3 is ......

## **Cilium Network Performance Testing**

### **Steps**

1. **Add the Cilium Helm Repository and Install Cilium**
   ```bash
   helm repo add cilium https://helm.cilium.io/
   helm install cilium cilium/cilium --version 1.12.0 --namespace kube-system
   ```

2. **Create a Namespace for Throughput Testing**
   ```bash
   kubectl create namespace network-cilium-performance-test
   ```

3. **Deploy Testing Pods using iperf3**

   - **Deploy server pod**:
     ```bash
     kubectl run iperf3-server --image=networkstatic/iperf3 --namespace=network-cilium-performance-test --command -- iperf3 -s
     ```

   - **Deploy client pod**:
     ```bash
     kubectl run iperf3-client --image=networkstatic/iperf3 --namespace=network-cilium-performance-test --command -- sleep infinity
     ```

4. **Start the Network Performance Test (Throughput)**

   - **Get the server pod IP**:
     ```bash
     kubectl get pod -o wide -n network-cilium-performance-test iperf3-server
     ```

   - **Run the client test using the server's IP**:
     ```bash
     kubectl exec -it iperf3-client -n network-cilium-performance-test -- iperf3 -c <server-ip>
     ```

### **Analysis**

The throughput test ran for 10 seconds, measuring the data sent between client and server pods. The average throughput was **85.2 Gbps**, with only **9 retransmissions**, indicating a stable network with minimal packet loss.

![Cilium Network Test](/Testing/Cilium-network-test.png)

---

## **Calico Network Performance Testing**

### **Steps**

1. **Create a Namespace for Throughput Testing**
   ```bash
   kubectl create namespace network-calico-performance-test
   ```

2. **Deploy Testing Pods using iperf3**

   - **Deploy server pod**:
     ```bash
     kubectl run iperf3-server --image=networkstatic/iperf3 --namespace=network-calico-performance-test --command -- iperf3 -s
     ```

   - **Deploy client pod**:
     ```bash
     kubectl run iperf3-client --image=networkstatic/iperf3 --namespace=network-calico-performance-test --command -- sleep infinity
     ```

3. **Start the Network Performance Test (Throughput)**

   - **Get the server pod IP**:
     ```bash
     kubectl get pod -o wide -n network-calico-performance-test iperf3-server
     ```

   - **Run the client test using the server's IP**:
     ```bash
     kubectl exec -it iperf3-client -n network-calico-performance-test -- iperf3 -c <server-ip>
     ```

### **Analysis**

The throughput test ran for 10 seconds, measuring the data sent between the client and server pods. The average throughput was **85.8 Gbps**, with only **8 retransmissions**, indicating a stable network with minimal packet loss.

![Calico Network Test](/Testing/Calico-network-test.png)

---

## **Larger Data Testing**

1. **Create a Large Cluster**
   ```bash
   kind create cluster --config kind-config-large.yaml --name larger-cluster
   ```

2. **Increase the Number of Pods**
   To scale up the workload, increase the number of pods. Example to create 100 NGINX pods:
   ```bash
   kubectl scale deployment nginx --replicas=100
   ```

3. **Apply StatefulSets** 

   StatefulSets simulate how Calico and Cilium handle networking for stateful applications:
   ```bash
   kubectl apply -f stateful.yaml --context kind-calico-cluster
   kubectl apply -f stateful.yaml --context kind-cilium-cluster
   ```

4. ***Throughput Testing***

   After deploying the pods and statefulsets, you need to simuate high network traffic. 

   A. Access each pod in a cluster:
   ```bash
   kubectl exec -it redis-0 --context kind-calico-cluster -- bash
   
   kubectl exec -it redis-0 --context kind-cilium-cluster -- bash
   ```
---

## **Conclusion**

Calico performed slightly better in terms of throughput, packet retransmissions, and congestion window growth, but the differences were minimal.
