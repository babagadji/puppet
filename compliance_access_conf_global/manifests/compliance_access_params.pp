class compliance_access_conf_global::compliance_access_params {
  case $facts['os']['family'] {
    'Redhat': {
      $service_name             = 'sssd'
      $filename                 = template('compliance_access_conf_global/access.conf.erb')
      $filepath                 = '/etc/security/access.conf'
      $just_check               = true
      $path_facter              = '/opt/puppetlabs/facter/facts.d/compare'
    }
    'Solaris': {
      $service_name             = 'name-service-cache'
      $filename                 = template('compliance_access_conf_global/user.allow.erb')
      $filepath                 = '/etc/user.allow'
      $just_check               = true
      $content_compliance       = '/etc/user.allow;/var/cache/puppetlabs/facts.d/compare/user.allow.erb'
      $content_compliance_check = 'puppet:///modules/compliance_access_conf_global/check_compliance.sh'
    }
    'AIX': {
      $service_name             = 'netcd'
      $filename                 = 'template'
      $filepath                 = '/etc/passwd'
      $just_check               = true
    }
    default: {
      fail("${facts['operatingsystem']} is not supported!")
    }
  }
}
