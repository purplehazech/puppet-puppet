# == Class: puppet::master
#
# Class responsible for configuring the puppet master.
#
class puppet::master (
  $install = true
) {

  if $install {
    package { 'puppet-master': 
      ensure => latest
    }
  }

  # @todo refactor to something closer to git
  package { 'puppet-infra-project': 
    ensure => latest
  }

  service { 'puppetmaster':
    ensure  => running,
    require => [
      Class['puppet'],
      Class['puppet::storeconfig'],
      Class['puppet::couch']
    ]
  }

}
