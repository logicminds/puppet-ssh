#
class ssh::config inherits ssh {
  # remove the include?
  include ssh::params

  file { '/etc/ssh/sshd_config':
    ensure  => file,
    content => template('ssh/sshd_config.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  file { $ssh::params::ssh_banner:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

}
