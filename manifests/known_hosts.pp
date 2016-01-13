class ssh::known_hosts(
  $host_key_info = {},
) {

  # sets the known hosts to the main ssh known hosts file under /etc/ssh/known_hosts
  $host_key_info.each |String $host, Hash $options| {
    sshkey { $host:
      ensure       => present,
      key          => $options['key'],
      host_aliases => $options['aliases'],
      type         => $options['key_type'],
    }
  }
}