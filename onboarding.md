#Preliminary documentation file to organize Heather's learning and give new members easy access to core onboarding information; will revisit for formatting + I still have a bulk of info elsewhere that I'm still learning how to work with before committing

<u><strong>Networking Basics</strong></u>

1. **OSI Model and TCP/IP**
   OSI (Open Systems Interconnection) Model:
      - 7 layers which work together to transmit data from one person to another across the globe
      - theoretical as opposed to being directly implemented in its entirety in real-world networking hardware or software; introduces core principals
        that specific protocols and technologies are based on
      - reference framework for explaining the process of transmitting data between computers
        
      7 layers:
       1\. Physical layer
           Lowest layer. Responsible for the actual physical connection between the devices. Contains information in the form of bits.
           Responsible for transmitting individual bits from one node to the next. Converts recieved signals into 0s and 1s and sends them to the
           Data Link layer.
       2\. **data link layer**
         - In Kubernetes, this layer involves Ethernet frames within a signle subnet
         - Kubernetes assumes nodes within the same cluster can communicate directly at this layer
       3\. **network layer**
         - In Kubernetes, primary layer for pod-to-pod communication across nodes
         - IP Addressing: Pods and nodes are assigned IP addresses within defined subnets
         - Routing mechanisms ensure traffic between services and pods is directed correctly across the cluster
            - Cilium manages routing decisions with eBPF
       4\. **transport layer**
         - In Kubernetes, primary layer for Kubernetes services and network policies such as TCP
         - Service Ports: services are associated with points at this layer, allowing communication to specific applications or
           services running inside pods within the cluster
         - Port Mapping: Kubernetes employs an abstraction layer that maps external requests to pods running within the cluster
                         When external traffic is directed to a Kubernetes service, the service forwards requests to the proper
                         pod based on the port mappings.
       5\. session layer
       6\. presentation layer
       7\. application layer
   
   TCP (Transmission Control Protocol)/IP (Internet Protocol) stack/suite
    - IP obtains address where data is sent (IP address); TCP ensures accurate data delivery once IP address has been found
    - IP sorts, TCP sends/receives

  Layers of the TCP/IP model: network access, internet, transport, and application; together form suite of protocols

  Data passes through these layers in the following order:
  Layer 1: Network Access Layer/Data Link Layer
      - handles the physical infrastructure that allows computers to communicate with one another over the internet
          - this covers ethernet cables, wireless networks, etc
      - also includes the technical infrastructure that makes network connection possible, which is the code that converts digital data into  
        transmittable signals
  
  Layer 2: Internet layer/network layer- controls the flow and routing of traffic to ensure data is sent speedily and accurately
      - responsible for reassembling the data packet at its destination
  
  Layer 3: transport layer- provides a reliable data connection between two communicating devices
      - divides the data in packets, acknowledges the packets it has received from the sender, and ensures that the recipient acknowledges the packets it receives
  
  Layer 4: application layer- the group of applications that let the user access the network (email, essaging apps, cloud storage programs)
      - what the end-user sees and interacts with when sending and receiving data

      
3. **IP Addressing and Subnetting**
   IP addresses contain two parts:
    1) Network ID: specifies a device's location in the network
    2) Host ID: labels a specific device in that location
       
   IPv4 and IPv6 are the two main types of IP addresses 
   IPv4:
   - has 4 strings of numbers consisting of 8 bits each, represented by 0 to 255 in numerical forms, separated by decimals
   - decimals section off these 4 numbers so they are each a section of 8 bits, together making 32 bites -> 4 bytes
   - this allows for 4.3 billion unique IP addresses; however, cannot provide enough addresses for growing internet demands, so becoming less used in comparison to IPv6

   IPv6:
   - uses 8 groups of 4 hexadecimal characters
   - the first three of these 8 groups are part of the routing prefix
   - the fourth group is the subnet IP
   - the last four groups are the Interface ID
   - this allows for exponentially more IP addresses than IPv4


   <u><strong> Subnetting:</strong></u>
   Subnet Mask: 32-bit number that divides host's IP address into network ID and host ID; helps determine the network area subnets
   belong in
   Subnetworks (subnets):
   - isolated network segments that are the result of administrators subdividing networks into smaller, more manageable sections, which allows
     them to control the flow of network traffic
       - enhances security by isolating traffic for privacy; an admin may do this to prevent certain traffic types from
         from the rest of the network where they could be vulnerable to incerception
           - ex) admin isolates all computers in the finance departmnet to a single subnet, which prevents finance
                 network communications from across the entire network 
       - enhances performance by managing traffic/reducing network congestion; decrease competition for network across congested networks
           - ex) if an organization's engineering department frequently transfers files that affect network performance for other users,
                 network admins can isolate the engineers to their own subnet, reducing the effect of their file transfers on other users
   - each subnet has a unique identifier within the larger network ID

3. **Routing and Switching**
   Internal Cluster Routing:
      - Pod-to-Pod communication: Kubernetes uses overlay networks for pod-to-pod communicatoin across nodes
      - each pod recieves an IP address
   External Connectivity:
      - Kubernetes clusters connect to external networks through ingress and engress routes
5. **Domain Name System (DNS)**


<u><strong>Deploying First Kubernetes Cluster with AKS</strong></u>
in command prompt: 
    1) log in to Azure: az login, select account, select subscription- StudentCloud did not enable the permissions required to create a kluster, so 
       use Azure Student service instead
    2) create the resource group: az group create --name test-Cilium-rg --location eastus
        "test" is environment, "Cilium" is project name, "rg" represents resource group.
        This creates the resource group "test-Cilium-rg" in the "eastus" region
    3) create the AKS Cluster: az aks create --resource-group test-Cilium-rg --name test-Cilium-aks --node-count 1 --enable-addons monitoring --
       generate-ssh-keys
        - az: command-line tool (CLI) for Azure
        - aks: specifies that we are interacting with Azure Kubernetes Service(AKS)
        - create: instructs the CLI to create a new AKS Cluster
        - --resource-group test-Cilium-rg: specifies name of the Azure resource group where AKS cluster will be created
            *resource groups are containers that Azure resources*
        - --name test-Cilium-aks: specifies the name for the AKS cluster that will be created
        - --node-count 1: specifies the initial number of nodes in the AKS cluster
            *Nodes: virtual machines that run Kubernetes and your applications*
        - --enable-addons monitoring: enables monitoring add-ons for the AKS cluster
        - --generate-ssh-keys: generates SSH keys for secure access to the cluster nodes
    4) configure kubectl to connect to your AKS Cluster: az aks get-credentials --resource-group test-Cilium-rg --name test-Cilium-aks
        - get-credentials: retrieves and merges the credentials for the specified AKS cluster into the local Kubernetes configuration file 
                           (~/.kube/config)
            - Kubernetes Configuration (~/.kube/config): a YAML file located in the home directory (~) of the user on a local machine
            - This file is usually created when you install kubectl or initialize a Kubernetes cluster context using commands like "az aks get-
              credentials"
            - retrieves necessary credentials (like certificates and tokens) from Azure for the specified AKS cluster (--name test-Cilium-aks) 
              located in the specified resource group (--resource-group <test-Cilium-rg>)
        - after running this command, your specified AKS cluster becomes the current context in your local Kubernetes configuration,
          which means all subsequent 'kubectl' commands will interact with this AKS by default until changed
    5) verify the AKS cluster: kubectl get nodes
