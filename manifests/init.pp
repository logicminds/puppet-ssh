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
    $allow_groups              = '',
    $allow_tcp_forwarding      = 'no',
    $allow_users               = '',
    $ciphers                   = 'aes128-ctr,aes192-ctr,aes256-ctr',
    $client_alive_count_max    = '0',
    $client_alive_interval     = '300',
    $deny_groups               = '',
    $deny_users                = '',
    $hostbased_authentication  = 'no',
    $ignore_rhosts             = 'yes',
    $listen_address            = '0.0.0.0',
    $log_level                 = 'VERBOSE',
    $macs                      = 'hmac-sha1',
    $max_auth_tries            = '4',
    $package_ensure            = 'present',
    $package_name              = 'openssh-server',
    $permit_empty_passwords    = 'no',
    $permit_root_login         = 'no',
    $permit_user_environment   = 'no',
    $port                      = '22',
    $protocol                  = '2',
    $rhosts_rsa_authentication = 'no',
    $service_enable            = true,
    $service_ensure            = 'running',
    $ssh_banner                = '/etc/motd',
    $sshd_config_template      = 'ssh/sshd_config.erb',
    $x11_forwarding            = 'no',
  ) {

  validate_re($allow_tcp_forwarding,
    ['yes', 'no']
  )

  validate_re($ciphers,
    ['3des-cbc', 'aes128-cbc', 'aes192-cbc', 'aes256-cbc', 'aes128-ctr',
    'aes192-ctr', 'aes256-ctr', 'arcfour128', 'arcfour256', 'arcfour',
    'blowfish-cbc', 'cast128-cbc']
  )

  validate_re($hostbased_authentication,
    ['yes', 'no']
  )

  validate_re($ignore_rhosts,
    ['yes', 'no']
  )

  validate_re($log_level,
    ['QUIET', 'FATAL', 'ERROR', 'INFO', 'VERBOSE',
    'DEBUG', 'DEBUG1', 'DEBUG2', 'DEBUG3']
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

  validate_re($x11_forwarding,
    ['yes', 'no']
  )


  package { $package_name:
    ensure        => $package_ensure,
    allow_virtual => true,
  }

  # linux06.2001: Set SSH protocol to 2
  # linux06.2002: Set LogLevel to VERBOSE
  # linux06.2003: Set permissions on /etc/sshd_config
  # linux06.2004: Disable SSH X11 Forwarding
  # linux06.2005: Set SSH MaxAuthTries to 4 or less
  # linux06.2006: Set IgnoreRhosts to Yes
  # linux06.2007: Set HostbasedAuthentication to No
  # linux06.2008: Disable SSH root login
  # linux06.2009: Set SSH PermitEmptyPasswords to No
  # linux06.2010: Do not allow users to set environment options
  # linux06.2011: Use only approved ciphers in counter mode
  # linux06.2012: Set idle timeout intervale for user login
  # linux06.2013: Limit access via SSH
  # linux06.2014: Set SSH banner
  file { '/etc/ssh/sshd_config':
    ensure  => file,
    content => template('ssh/sshd_config.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package[$package_name],
    notify  => Service['sshd'],
  }

  service { 'sshd':
    ensure => $ssh::service_ensure,
    enable => $ssh::service_enable,
  }

}
