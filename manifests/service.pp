#
class ssh::service inherits ssh {

  service { 'sshd':
    ensure => $service_ensure,
    enable => $service_enable,
  }

}
