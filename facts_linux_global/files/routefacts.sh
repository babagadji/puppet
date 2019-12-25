#!/bin/sh
iproutes=`/sbin/ip route | egrep -v 'default|kernel|169\.254\.0\.0'|awk 'BEGIN { OFS = ";";} {print $1,$3}'`
compliance_routes="true"

permanent_routes=$(cat /etc/sysconfig/network-scripts/route-* 2>/dev/null| awk 'BEGIN { OFS = ";";} { print $1,$3 }')

if [ ! -z "$permanent_routes_exist" ]
then
    # premanent_routes=`/bin/cat /etc/sysconfig/network-scripts/route-*`
  evaluate()
  {
  printf '%s\n' $iproutes | while read -r route
     do
        grep -q $route <<<"$permanent_routes"
        if [ "$?" -eq "1" ]
         then
          return 101
        fi
     done
  }
evaluate
NOT_COMPLIANT=$?
if [  "$NOT_COMPLIANT" -eq "101" ]
then
compliance_routes="false"
fi
fi

if [[ ($(/sbin/ip route | egrep -v 'default|kernel|169\.254\.0\.0' |wc -l) -ne 0 ) && ($(ls /etc/sysconfig/network-scripts |egrep -c '^route') -eq 0) ]]
then
   compliance_routes="false"
fi

echo compliance_routes=$compliance_routes
