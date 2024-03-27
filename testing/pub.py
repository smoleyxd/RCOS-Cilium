import socket
import time

MCAST_GRP = '224.1.1.1'
MCAST_PORT = 5007

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP)
sock.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 2)  # Set TTL to 2

while True:
    message = "Testing Multicast".encode()
    sock.sendto(message, (MCAST_GRP, MCAST_PORT))
    print(f"Sent message: {message}")
    time.sleep(5)
