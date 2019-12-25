class compliance_access_conf_global::compliance_access_file(
  $filename                 = $::compliance_access_conf_global::filename,
  $filepath                 = $::compliance_access_conf_global::filepath,
  $just_check               = $::compliance_access_conf_global::just_check,
  $content_compliance       = $::compliance_access_conf_global::content_compliance,
  $content_compliance_check = $::compliance_access_conf_global::content_compliance_check,
)
{
  if $facts['os']['family'] == 'RedHat' {
    file { "/etc/security/access.conf":
      ensure   => file,
      mode     => '0600',
      owner    => 'root',
      group    => 'root',
      path     => $filepath,
      content  => $filename,
      noop     => $just_check
     }
    
    file { "copy file to compare folder":
      ensure   => file,
      path     => "$path_facter/access.conf.erb",
      owner    => 'root',
      group    => 'root',
      mode     => '0600',
      content  => $filename,
    }
   }
  elsif $facts['os']['family'] == 'Solaris' {
    file { "/etc/user.allow":
      ensure     => file,
      mode       => '0600',
      owner      => 'root',
      group      => 'root',
      path       => $filepath,
      content    => $filename,
      noop       => $just_check
    }
    file { 'create folder compare':
      ensure     => directory,
      mode       => '0755',
      owner      => 'root',
      group      => 'root',
      path       => '/var/cache/puppetlabs/facts.d/compare',
     }
  
    file { "copy file folder":
      ensure     => file,
      path       => '/var/cache/puppetlabs/facts.d/compare/user.allow.erb',
      owner      => 'root',
      group      => 'root',
      mode       => '0740',
      content    => $filename,
    } 
    file { 'compliances_files':
      ensure     => file,
      owner      => 'root',
      group      => 'root',
      mode       => '0744',
      path       => '/var/cache/puppetlabs/facts.d/compliances_files',
      content    => $content_compliance,
    }
    file { 'check_compliance.sh':
      ensure     => file,
      owner      => 'root',
      group      => 'root',
      mode       => '0744',
      path       => '/var/cache/puppetlabs/facts.d/check_compliance.sh',
      source     => $content_compliance_check,
    }

 
  }
  elsif $facts['os']['family'] == 'AIX' {

  }
  else {
     fail("${facts['operatingsystem']} is not supported!")
   }
}
