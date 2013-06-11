# == Class: puppet
#
# Install puppet on a box
#
# === Parameters:
# [*server*]
#   where to find the puppetmaster (defaults to puppet)
# [*install*]
#   toggle installation of puppet packages
#
class puppet (
  $master     = 'puppet',
  $install    = true,
  $pluginsync = true
) {
  
  include puppet::gentoo
  $puppet_pluginsync    = false
  $conf_file     = '/etc/puppet/puppet.conf'
  
  package { 'puppet': 
    ensure => installed,
    before => Augeas['puppet-config']
  }

  augeas { 'puppet-config':
    context => '/files/etc/puppet/puppet.conf',
    changes => [
      'set agent/report true',
      "set agent/server ${master}",
      "set agent/pluginsync ${pluginsync}",
    ]
  }

  service { 'puppet': 
    ensure => running
  }
}

