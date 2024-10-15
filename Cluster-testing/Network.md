**Throughput and Latency**: 
Measure the raw data transfer speeds and the delay between packet transmissions across the cluster nodes.

**Cilium**:
<br>
<br>
Steps: 

   1. Add the Cilium Helm Repository and install cilium with helm:

   helm repo add cilium https://helm.cilium.io/
   helm install cilium cilium/cilium --version 1.12.0 --namespace kube-system
   2. Create a namespace for Cilium Throughput testing:
   <br>
   - kubectl create namespace network-cilium-performance-test
    <br>
   3. Deploy Pods for Testing using iperf3:
   - Deploy server pod: 
   <br>
   kubectl run iperf3-server --image=networkstatic/iperf3 --namespace=network-cilium-performance-test --command -- iperf3 -s

   - Deply client pod: <br>
   kubectl run iperf3-client --image=networkstatic/iperf3 --namespace=network-cilium-performance-test --command -- sleep infinity

   4. Start the Network Performance Test (Throughput):
    <br>
    - Get serverpod IP: 
    <br>
    kubectl get pod -o wide -n network-cilium-performance-test iperf3-server
    -  Run client test using IP:
    <br>
    kubectl exec -it iperf3-client -n network-cilium-performance-test -- iperf3 -c 10.0.0.155

![Cilium network test:](/Testing/Cilium-network-test.png)

   **Analysis:**
   <br>
   The throughput test ran for 10 seconds meansuring how much data was sent between the client and server pods. The average throughput is 85.2 gb/s which is extremely fast. There were only 9 retransmissions, which is a low number, indicating that the network is relatively stable with minimal packet loss.

<br>

**Calico**:
<br>
<br>
Steps:

1. Create a Namespace for Calico Throughput Testing:
kubectl create namespace network-calico-performance-test
2. Deploy Pods for Testing using iperf3:
   - Deploy server pod: 
   <br>
   kubectl run iperf3-server --image=networkstatic/iperf3 --namespace=network-calico-performance-test --command -- iperf3 -s

   - Deply client pod: <br>
   kubectl run iperf3-client --image=networkstatic/iperf3 --namespace=network-calico-performance-test --command -- sleep infinity
3. Start the Network Performance Test (Throughput):
    <br>
    - Get serverpod IP: 
    <br>
    kubectl get pod -o wide -n network-calico-performance-test iperf3-server
    -  Run client test using IP:
    kubectl exec -it iperf3-client -n network-calico-performance-test -- iperf3 -c 10.0.0.90

![Calico network test:](/Testing/Calico-network-test.png)

   **Analysis:**
   <br>
   The throughput test ran for 10 seconds meansuring how much data was sent between the client and server pods. The average throughput is 85.8 gb/s which is extremely fast. There were only 8 retransmissions, which is a low number, indicating that the network is relatively stable with minimal packet loss.

   Larger Data Test:

   **Concluison**:
   Calico performed slightly better in terms of throughput, packet retransmissions, and congestion window growth, but the differences were very small.