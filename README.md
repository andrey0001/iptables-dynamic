# Use iptables with ipset and dymanic ip-s.

Small sripts to use with iptables for dynamic ip.

ipsetd - add ip of domain to ipset list (even if domain has more that one ip) . Check path of ipset programm inside.
> ipsetd (listname) (domain)

trustlist.sh - add multiple domains to ipset. Also for use with cron. You can customize ipset list name by cli argument 1. By default name is trust-ip
> trustlist.sh [listname]

Check and edit DomainsArray in trustlist.sh before use

Create new ipset list "trust-ip": ipset create trust-ip hash:ip

Run trustlist.sh

Add rule to iptables:
> iptables -I INPUT -m set --match-set trust-ip src -j ACCEPT

Then add cron job:
> */5 * * * * /root/bin/trustlist.sh trust-ip

Every 5 min list will be renewed 


