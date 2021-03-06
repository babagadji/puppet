# == Class: cagip_facts
# Full description of class ntp here.
#
# === Parameters
#
# Document parameters here.

class facts_linux_global () {

   
   file { 'ntpfacts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    path    => '/opt/puppetlabs/facter/facts.d/ntpfacts.sh',
    content => file('facts_linux_global/ntpfacts.sh'),
  }
  file { 'dnsfacts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    path    => '/opt/puppetlabs/facter/facts.d/dnsfacts.sh',
    content => file('facts_linux_global/dnsfacts.sh'),
  }

  file { 'routefacts':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    path    => '/opt/puppetlabs/facter/facts.d/routefacts.sh',
    content => file('facts_linux_global/routefacts.sh'),
  }

  file { 'compliance_files':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    path    => '/opt/puppetlabs/facter/compliance_files',
  }

  file { 'check_compliance.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0744',
    path    => '/opt/puppetlabs/facter/facts.d/check_compliance.sh',
    content => file('facts_linux_global/check_compliance.sh'),
     }
 
  file{ 'add compare_folder':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    path    => '/opt/puppetlabs/facter/facts.d/compare/',
  }


  file { "add file hostgroup.txt":
     ensure => file,
     owner => 'root',
     group => 'root',
     content => "hostgroup=$hostgroup",
     path  => '/opt/puppetlabs/facter/facts.d/hostgroup.txt',
  }

  #file {'create file access.conf.erb to compare':
  #  ensure  => file,
   # owner   => 'root',
   # group   => 'root',
    #mode    => '0744',
    #path    => '/opt/puppetlabs/facter/facts.d/access.conf.erb',
    #content => template ('compliance_access_conf_global/access.conf.erb'),
  #}

  #file {'create file user.allow.erb to compare':
   # ensure  => file,
    #owner   => 'root',
    #group   => 'root',
    #mode    => '0744',
    #path    => '/var/cache/puppetlabs/facts.d/user.allow.erb',
    #content => template ('compliance_access_conf_global/user.allow.erb'),
  #}
  

  ##controlling the facts 
  #$customfacts = ['sshd_config','resolv.conf','ntp.conf']
   # $customfacts.each |String $customfact| {
    #    file_line {"add_fact_${customfact}_file":
      #      path    => '/opt/puppetlabs/facter/facts.d/configfile_compliance',
      #      match   => "^echo compliance_${customfact}_file",
      #      line    => "echo compliance_${customfact}_file=",
      #      replace => false,
    #    }
  #   }

  
}
