#!/bin/bash

# -vv very verbose
# -Pn treat hosts as online
# -sS 
# -p which port(s)
# -iR 0 UNLIMITED RANDOM IPs

sudo tsocks proxychains nmap -vv -Pn -sS -p $@ -iR 0 --open | tee -a port$@.nmap
