#!/bin/bash
# Author Andrey Sorokin aka shadow_alone

#Set path for ipset and ipsetd
IPSET="/usr/sbin/ipset"
IPSETD="/root/bin/ipsetd"

# Add domain to array
DomainsArray=("rg.andrey.org" "ip.allow.andrey.im")

# Use command-line argument to provide ipset list name (Default: trust-ip)
REALLISTNAME=$1
[ -z "$1" ] && REALLISTNAME="trust-ip-rg"

# Creation of temporary ipset list name
LISTNAME="list-"`date +%s`

$IPSET create $LISTNAME hash:ip

#Add domains to ipset list
for str in ${DomainsArray[@]}; do
  $IPSETD $LISTNAME $str
done

$IPSET swap $LISTNAME $REALLISTNAME
$IPSET destroy $LISTNAME

