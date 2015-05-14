#
class ssh::service inherits ssh {

  service { 'sshd':
    ensure => running,
    enable => true,
  }

}
