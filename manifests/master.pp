# == Class: puppet::master
#
# Class responsible for configuring the puppet master.
#
class puppet::master (
  $ensure => enabled,
) {

  case $::operatingsystem {
    # gentoo installs master through main package
    Gentoo: {}
    # others need packages
    default: {
      package { 'puppet-master': 
        ensure => $ensure,
      }
    }
  }

  service { 'puppetmaster':
    ensure  => running,
    enabled => true,
    require => [
      Class['puppet'],
    ]
  }

}

