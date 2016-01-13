class ssh::known_hosts(
  $host_key_info = {},
) {

  # sets the known hosts to the main ssh known hosts file under /etc/ssh/known_hosts
  $host_key_info.each |String $host, String $key| {
    sshkey { $host:
      ensure => present,
      key    => $key,
      type   => 'ssh-rsa',
    }
  }
}