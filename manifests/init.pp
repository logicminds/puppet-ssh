# Class: ssh
#
# This module manages ssh
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class ssh (
    $allow_tcp_forwarding      = $ssh::params::allow_tcp_forwarding,
    $ciphers                   = $ssh::params::ciphers,
    $client_alive_count_max    = $ssh::params::client_alive_count_max,
    $client_alive_interval     = $ssh::params::client_alive_interval,
    $hostbased_authentication  = $ssh::params::hostbased_authentication,
    $ignore_rhosts             = $ssh::params::ignore_rhosts,
    $log_level                 = $ssh::params::log_level,
    $macs                      = $ssh::params::macs,
    $max_auth_tries            = $ssh::params::max_auth_tries,
    $package_ensure            = $ssh::params::package_ensure,
    $permit_empty_passwords    = $ssh::params::permit_empty_passwords,
    $permit_root_login         = $ssh::params::permit_root_login,
    $permit_user_environment   = $ssh::params::permit_user_environment,
    $port                      = $ssh::params::port,
    $protocol                  = $ssh::params::protocol,
    $rhosts_rsa_authentication = $ssh::params::rhosts_rsa_authentication,
    $ssh_banner                = $ssh::params::ssh_banner,
    $sshd_config_template      = $ssh::params::sshd_config_template
  ) inherits ssh::params {

  validate_re($allow_tcp_forwarding,
    ['yes', 'no']
  )

  validate_re($ciphers,
    ['3des-cbc', 'aes128-cbc', 'aes192-cbc', 'aes256-cbc', 'aes128-ctr', 'aes192-ctr', 'aes256-ctr', 'arcfour128', 'arcfour256', 'arcfour', 'blowfish-cbc', 'cast128-cbc']
  )

  validate_re($hostbased_authentication,
    ['yes', 'no']
  )

  validate_re($ignore_rhosts,
    ['yes', 'no']
  )

  validate_re($log_level,
    ["QUIET", "FATAL", "ERROR", "INFO", "VERBOSE", "DEBUG", "DEBUG1", "DEBUG2", "DEBUG3"]
  )

  validate_re($permit_empty_passwords,
    ['yes', 'no']
  )

  validate_re($permit_root_login,
    ['yes', 'no', 'without-password', 'forced-commands-only']
  )

  validate_re($permit_user_environment,
    ['yes', 'no']
  )

  validate_re($rhosts_rsa_authentication,
    ['yes', 'no']
  )

  include ssh::install
  include ssh::config
  include ssh::service

  Class['ssh::params'] -> Class ['ssh::install'] -> Class ['ssh::config'] ~> Class ['ssh::service']

}
