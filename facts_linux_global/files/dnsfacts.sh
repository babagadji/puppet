#!/bin/sh

dns_servers_resolv_list=$( cat /etc/resolv.conf |grep -i '^nameserver'| awk '{ print $2 }')
dns_servers_ifcfg_list=$(cat /etc/sysconfig/network-scripts/ifcfg-*|grep -i '^DNS'| awk '{ print $2 }' | sed 's/"//g')

i=0
for nameserver in `echo "$dns_servers_resolv_list" `
do
    let "i=i+1"
    echo "DNS$i"="$nameserver"
done

i=0
for nameserver_ifcfg in `echo "$dns_servers_ifcfg_list" `
do
    let "i=i+1"
    echo "DNS_ifcfg$i"="$nameserver_ifcfg"
done
