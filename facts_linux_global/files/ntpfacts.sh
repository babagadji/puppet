#!/bin/sh
#parse ntpq results to return configured ntp servers
ntpservers=$(/usr/sbin/ntpq -pn | egrep '^\*|^\+' | awk '{print substr($1,2);}' | sed ':a;N;$!ba;s/\n/,/g' )

#extract ntp offset and remove the negative sign if exists
ntp_offset=$(/usr/sbin/ntpq -pn | /usr/bin/awk 'BEGIN { offset=1000 } $1 ~ /^\*/ { offset=$9 } END { print offset }'|tr -d '-')

#max threshhold for offset
thresh_critical=500

# If NTP offset is higher than the critical threshold set ntp_offset_critical to true
if (( $(echo "$ntp_offset < $thresh_critical" | bc -l) )) ; then
   ntp_offset_critical=false
else
   ntp_offset_critical=true
fi


# if offset and ntp servers list are compliant , set ntp_compliance to true
if [ "$ntpservers" = "10.255.9.30,10.255.9.46,10.255.9.14" ] && [ "$ntp_offset_critical" = "false" ]
then
    ntp_compliance=true
else
    ntp_compliance=false
fi

## write facts
echo ntpservers="$ntpservers"
echo ntp_compliance="$ntp_compliance"
