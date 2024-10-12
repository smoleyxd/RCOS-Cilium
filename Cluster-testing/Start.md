What I woud like to work on this semester:
Deploying multiple clusters using different CNI’s 
such as Cilium and Calico to identify the pros and cons of each CNI 

I plan on displaying the data using a python libraries and 
recording anything I may found and the potential difference of
using Cilium vs Calico.


** Make sure you are on jon-onboarding branch**

For Linux/Mac:

10/8 Week:
- Installed calico
1. Installed kind to create multiple Kubernetes clusters on your local machine using Docker.
    - brew install kind 

Step-by-Step Guide to Use Docker with Kind
1. Cd into cluster-testing <br>

2. Check Docker Containers 
    - docker ps (it should be empty) <br> 
 
3. Creating a Multi-Node Cluster: <br>
-Enter into the terminal: <br> 
    a. Create a Kind cluster for testing with Calico: kind create cluster --name calico-cluster <br>
    b. Install Calico as the CNI by using the following YAML:
     "kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml" <br>
    c. Verify Calico installation: <br>
     - Type "kubectl get pods -n kube-system" into the terminal <br>


    ![Docker:](./Testing/Calico-start.png) 
    <br>

4. Create another Kind cluster for testing with Cilium: <br>
    a. Create a Kind cluster for testing with Calico: kind create cluster --name cilium-cluster <br>
    b. Install Celium using Helm: 
    helm repo add cilium https://helm.cilium.io/
helm install cilium cilium/cilium --version 1.12.0 --namespace kube-system <br>
    c. Verify Cilium installation: <br>
    - Type "kubectl get pods -n kube-system" into the terminal 

    
    ![Docker:](./Testing/Cilium.png) 
    <br>

Run Docker ps:
<br>
![Docker:](./Testing/Docker.png) 
<br>

Metrics:

 1. **Network Performance**
   - **Throughput and Latency**: Measure the raw data transfer speeds and the delay between packet transmissions across the cluster nodes.

   - **Packet Loss and Jitter**: Test for packet loss and variation in latency during heavy loads or under specific traffic patterns.

2. 




