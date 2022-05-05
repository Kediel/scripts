# -*- coding: utf-8 -*-
#!/usr/bin/python
"""
Created on Wed May  4 13:36:15 2022
https://www.cisco.com/c/en/us/support/docs/storage-networking/management/200933-YANG-NETCONF-Configuration-Validation.html
https://stackoverflow.com/questions/50305725/condahttperror-http-000-connection-failed-for-url-https-repo-continuum-io-pk

*remember to enable NETCONF/YANG on the asset by typing netconf-yang in a conf t
*Also need the ncclient library installed: pip install ncclient
"""
import sys, os, re, base64, socket
from ncclient import manager
    
# Get device run config
def test(host, user, pw):
    
    # Checks the python version installed on the system
    if sys.hexversion < 0x02030000:
        print("This script needs python version >= 2.3")
        sys.exit(1)
    
    m = manager.connect(host=host, port=830, username=user, password=pw, device_params={"name":"iosxe"})
    print("Connected to %s" % host)
    
    # Create a configuration filter
    interface_filter = '''
      <filter>
          <native xmlns="http://cisco.com/ns/yang/Cisco-IOS-XE-native">
              <interface>
                <GigabitEthernet>
                  <name>1</name>
                </GigabitEthernet>
              </interface>
          </native>
      </filter>
    '''
    
    # Execute the get-config RPC
    result = m.get_config('running', interface_filter)
    return result
    
if __name__ == "__main__":
    
    # Get user input
    host = input("What is the host? ")
    user = input("What is the username? ")
    pw = input("What is the password? ")
    
    # Call the function
    test(host,user,pw)
