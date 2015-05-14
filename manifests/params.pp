#
class ssh::params {

  $allow_tcp_forwarding      = 'no'
  $ciphers                   = 'aes128-ctr,aes192-ctr,aes256-ctr'
  $client_alive_count_max    = '0'
  $client_alive_interval     = '300'
  $hostbased_authentication  = 'no'
  $ignore_rhosts             = 'yes'
  $listen_address            = ''
  $log_level                 = "VERBOSE"
  $macs                      = 'hmac-sha1'
  $max_auth_tries            = '3'
  $package_ensure            = 'present'
  $permit_empty_passwords    = 'no'
  $permit_root_login         = 'no'
  $permit_user_environment   = 'no'
  $port                      = '22'
  $protocol                  = '2'
  $rhosts_rsa_authentication = 'no'
  $ssh_banner                = '/etc/motd'
  $sshd_config_template      = 'ssh/sshd_config.erb'

}
