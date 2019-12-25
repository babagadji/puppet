#!/bin/sh
set -x
compliance_files="/opt/puppetlabs/facter/compliance_files_`uname`"
if [ -f $compliance_files ]
then
 while read -r fullpath
 do
       filename=$(basename -- $fullpath)
       filepath=$(echo $fullpath|awk -F";" '{print $1}')
       comparepath=$(echo $fullpath|awk -F";" '{print $2}')
       diff -b ${comparepath} ${filepath} > /dev/null
        if [ "$?" -eq "0" ]
         then
          echo "compliance_${filename}_file=true"
         else
          echo "compliance_${filename}_file=false"
        fi
 done < "$compliance_files"
fi
