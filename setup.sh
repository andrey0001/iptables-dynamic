#!/bin/bash

apt update && apt install -y iptables-persistent ipset-persistent

DIR1="/root/bin"

[ -d $DIR1 ] || mkdir $DIR1

cp ipsetd $DIR1/
cp trustlist.sh $DIR1/

ipset create -! trust-ip-rg hash:ip

iptables -I INPUT -m set --match-set trust-ip-rg src -j ACCEPT

cat <<EOT > /etc/cron.d/trustlist
1-59/5 * * * * $DIR1/trustlist.sh trust-ip-rg
EOT



