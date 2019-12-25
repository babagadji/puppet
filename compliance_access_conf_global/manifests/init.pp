class compliance_access_conf_global (
  $service_name             = $::compliance_access_conf_global::compliance_access_params::service_name,
  $filename                 = $::compliance_access_conf_global::compliance_access_params::filename,
  $filepath                 = $::compliance_access_conf_global::compliance_access_params::filepath,
  $just_check               = $::compliance_access_conf_global::compliance_access_params::just_check, 
  $path_facter              = $::compliance_access_conf_global::compliance_access_params::path_facter,
  $content_compliance       = $::compliance_access_conf_global::compliance_access_params::content_compliance,
  $content_compliance_check = $::compliance_access_conf_global::compliance_access_params::content_compliance_check, 
) inherits ::compliance_access_conf_global::compliance_access_params {
  class { '::compliance_access_conf_global::compliance_access_file': } ->
  class { '::compliance_access_conf_global::compliance_access_service': } 
}
