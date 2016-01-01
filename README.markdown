# ssh

This module manages OpenSSH server with a specific focus on managing
security-related configurations in the sshd_config file.

## Setup

To use this module, simply `include ssh`. It will run with the default
parameter values (see [Parameters](#parameters) below) or with whatever
parameters have been specified in Hiera.

You can optionally use this module by declaring the class with your own values
by calling the class:

```puppet
class { ssh:
  client_alive_interval => '900',
  permit_root_login     => 'yes',
  port                  => '9009',
  x11_forwarding        => 'yes',
}
```

## Parameters

The module supports a number of parameters. Most of these are applied to the
sshd_config file via the [sshd_config.erb](templates/sshd_config.erb)
template, so values should be passed in as you would expect them to appear in
sshd_config. For information on how OpenSSH uses these values, refer to the
sshd_config manpage (`man sshd_config`).

### `allow_groups`

Defaults to an empty string, resulting in no entry being added to sshd_config.

### `allow_tcp_forwarding`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `allow_users`

Defaults to an empty string, resulting in no entry being added to sshd_config.

### `ciphers`

A comma-separated list of ciphers to support. Defaults to
'aes128-ctr,aes192-ctr,aes256-ctr'. Valid entries are:
- 3des-cbc
- aes128-cbc
- aes192-cbc
- aes256-cbc
- aes128-ctr
- aes192-ctr
- aes256-ctr
- arcfour128
- arcfour256
- arcfour
- blowfish-cbc
- cast128-cbc

### `client_alive_count_max`

Defaults to '0'.

### `client_alive_interval`

Defaults to '300'.

### `deny_groups`

Defaults to an empty string, resulting in no entry being added to sshd_config.

### `deny_users`

Defaults to an empty string, resulting in no entry being added to sshd_config.

### `hostbased_authentication`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `ignore_rhosts`

Valid values are 'yes', 'no'. Defaults to 'yes'.

### `listen_address`

The local address(es) that sshd should listen on. Defaults to '0.0.0.0' (all
local addresses).

### `log_level`

Sets the logging level for sshd. Valid values are 'QUIET', 'FATAL', 'ERROR',
'INFO', 'VERBOSE', 'DEBUG', 'DEBUG1', 'DEBUG2', 'DEBUG3'. Defaults to
'VERBOSE'.

### `macs`

Defaults to 'hmac-sha1'.

### `max_auth_tries`

Defaults to '4'.

### `package_ensure`

Sets the desired package state of the (SSH) package specified by the
[`package_name`](#package_name) parameter. Valid values are the same as those
for the [Puppet `package` resource](https://docs.puppetlabs.com/references/latest/type.html#package-attribute-ensure).
Note that specifying a package version number here will pin that version and
ensure it is installed (if available from a package repository). Defaults to
'present'.

### `package_name`

The name of the package to install. Defaults to 'openssh-server'.

### `permit_empty_passwords`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `permit_root_login`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `permit_user_environment`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `port`

The port on which sshd should listen. Defaults to '22'.

### `protocol`

Defaults to '2'.

### `rhosts_rsa_authentication`

Valid values are 'yes', 'no'. Defaults to 'no'.

### `service_enable`

Whether the sshd service should be started on boot. Valid values
are the same as those for the [Puppet `service` resource](https://docs.puppetlabs.com/references/latest/type.html#service-attribute-enable).
Defaults to `true`.

### `service_ensure`

The desired state of the sshd service. Valid values are the same as those for the [Puppet `service` resource](https://docs.puppetlabs.com/references/latest/type.html#service-attribute-ensure).
Defaults to 'running'.

### `ssh_banner`

The banner to apply for SSH logins. Defaults to '/etc/motd'.

### `x11_forwarding`

Valid values are 'yes', 'no'. Defaults to 'no'.
