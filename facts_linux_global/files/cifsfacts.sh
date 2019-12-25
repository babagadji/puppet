#/bin/sh
cifsfound=$(mount -l|grep -i 'type cifs'|awk 'BEGIN { OFS = ";";} {print $1,$3}')
compliance_cifs="true"
info_cifs_exist="false"
permanent_cifs=$(awk 'BEGIN { OFS = ";"; ORS = "\n\n" } { print $1,$2 }' /etc/fstab 2>/dev/null)

if [ ! -z "$cifsfound" ]
then
    # premanent_routes=`/bin/cat /etc/sysconfig/network-scripts/route-*`
  info_cifs_exist="true"
  evaluate()
  {
  printf '%s\n' $cifsfound | while read -r cifsentry
     do
        grep -q ^$cifsentry <<<"$permanent_cifs"
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
compliance_cifs="false"
fi
fi

echo info_cifs_exist=$info_cifs_exist
echo compliance_ciffs=$compliance_cifs
