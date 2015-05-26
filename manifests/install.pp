#
class ssh::install inherits ssh {

  package { $package_name:
    ensure        => $package_ensure,
    allow_virtual => true,
  }

}
