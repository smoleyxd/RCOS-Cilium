#Documentation file to organize Heather's learning and give new members easy access to core onboarding information; I've already written a bulk of info elsewhere, just need to transfer it

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
