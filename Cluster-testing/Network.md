**Throughput and Latency**: 
Measure the raw data transfer speeds and the delay between packet transmissions across the cluster nodes.

   Steps: 

   1. Create a namespace for testing:
   <br>
   - kubectl create namespace network-performance-test
    <br>
   2. Deploy Pods for Testing using iperf3:
   - Deploy server pod: 
   <br>
   kubectl run iperf3-server --image=networkstatic/iperf3 --namespace=network-performance-test --command -- iperf3 -s

   - Deply client pod: <br>
   kubectl run iperf3-client --image=networkstatic/iperf3 --namespace=network-performance-test --command -- sleep infinity

   3. Start the Network Performance Test (Throughput):
    <br>
    - Get serverpod IP: 
    <br>
    kubectl get pod -o wide -n network-performance-test iperf3-server
    -  Run client test:


