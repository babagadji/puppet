#!/bin/sh
OStype=`uname`

case "$OStype" in
        Linux)
        access_conf_servers_netgroup_list=$( cat /etc/security/access.conf| grep -i '^+:@' | cut -d : -f 2| cut -d @ -f 2 )
        access_conf_servers_user_list=$(cat /etc/security/access.conf| grep -i '^+:'| grep -v @| cut -d : -f 2| cut -d @ -f 2| grep -v root| grep -v sysadm)

        echo list_netgroups=$access_conf_servers_netgroup_list
        echo list_users=$access_conf_servers_user_list

        i=0
        for netgroup in `echo "$access_conf_servers_netgroup_list" `
        do
                let "i=i+1"
                if [[ $netgroup = $HOSTNAME ]]
                then
                        echo "netgroup_hostname"=$HOSTNAME ;
                fi
        done

        i=0
        for user in `echo "$access_conf_servers_user_list" `
        do
        let "i=i+1"
        done
        ;;

        SunOS)
        user_allow_servers_netgroup_list=$(cat /etc/user.allow | grep -i '^@'| cut -d @ -f2)
        user_allow_servers_user_list=$(cat /etc/user.allow | grep -i '^[a-z]'|grep -v root | grep -v sysadm)

        echo list_netgroups=$user_allow_servers_netgroup_list
        echo list_users=$user_allow_servers_user_list
        ;;

        AIX)
        passwd_servers_netgroup_list=$(cat /etc/passwd | grep -i '^+@' | cut -d '@' -f2)
        passwd_servers_user_list=$(cat /etc/passwd | grep -i '^+[a-z]' | cut -d '+' -f2)

        echo list_netgroups=$passwd_servers_netgroup_list
        echo list_users=$passwd_servers_user_list
        ;;

        *) echo "UNKNOWN $OStype";;
esac
