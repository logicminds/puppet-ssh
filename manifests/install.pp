#
class ssh::install inherits ssh {

  package { 'openssh-server':
    ensure => 'present',
  }

}
