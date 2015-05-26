#
class ssh::config inherits ssh {

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
  }

  file { $ssh::params::ssh_banner:
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

}
