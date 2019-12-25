#/bin/sh
nfsfound=$(mount -l|grep -i 'type nfs'|awk 'BEGIN { OFS = ";";} {print $1,$3}')
compliance_nfs="true"
info_nfs_exist="false"
permanent_nfs=$(awk 'BEGIN { OFS = ";"; ORS = "\n\n" } { print $1,$2 }' /etc/fstab 2>/dev/null)

if [ ! -z "$nfsfound" ]
then
    # premanent_routes=`/bin/cat /etc/sysconfig/network-scripts/route-*`
  info_nfs_exist="true"
  evaluate()
  {
  printf '%s\n' $nfsfound | while read -r nfsentry
     do
        grep -q ^$nfsentry <<<"$permanent_nfs"
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
compliance_nfs="false"
fi
fi

echo info_nfs_exist=$info_nfs_exist
echo compliance_nfs=$compliance_nfs
