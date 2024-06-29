#Documentation file to organize Heather's learning and give new members easy access to core onboarding information; I've already written a bulk of info elsewhere, just need to transfer it

<u><strong>Networking Basics</strong></u>

1. **OSI Model and TCP/IP**
   OSI Model:

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

4. **Routing and Switching**
5. **Domain Name System (DNS)**
