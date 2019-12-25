class compliance_access_conf_global::compliance_access_service (
  String $service_name = $::compliance_access_conf_global::service_name,
){
  if $facts['os']['family'] == 'RedHat' {
   service {'sssd':
     hasrestart => true,
   }
  }
  elsif $facts['os']['family'] == 'AIX' {
    service {'netcd':
      ensure => running,
      restart => true,
    }
  }
  elsif $facts['os']['family'] == 'Solaris' {
  } 
  else {
    fail("${facts['operatingsystem']} is not supported!")
  }

}
