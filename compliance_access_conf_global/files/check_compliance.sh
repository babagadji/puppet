#!/bin/sh
value=true
compliances_files="/var/cache/puppetlabs/facts.d/compliances_files"
if [ -f "$compliances_files" ]
then 
       filepath=$(more "$compliances_files" | cut -d";" -f1)
       comparepath=$(more "$compliances_files" | cut -d";" -f2)
       diff -b $comparepath $filepath > /dev/null
        if [ "$?" -eq "0" ]
         then
          echo compliance_access.conf.erb_file=$value
         else
          value=false
          echo compliance_access.conf.erb_file=$value
        fi
fi
