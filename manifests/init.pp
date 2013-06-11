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
  $master = 'puppet',
  $install = true
) {
  
  case $::operatingsystem {
    windows: {
      $puppet_pluginsync    = false
      $conf_file     = 'C:\Dokumente und Einstellungen\All Users\Anwendungsdaten\PuppetLabs\puppet\etc\puppet.conf'
      $conf_template = 'puppet.conf.win.erb'
    }
    default: {
      include puppet::gentoo
      $puppet_pluginsync    = false
      $conf_file     = '/etc/puppet/puppet.conf'
      $conf_template = 'puppet.conf.erb'
    }
  }
  
  # @todo also change in win tpl
  $pluginsync = $puppet_pluginsync

  package { 'puppet': 
    ensure => installed,
    before => File[$conf_file]
  }

  file { $conf_file:
    content => template("puppet/${conf_template}"),
    notify  => Service['puppet']
  }

  service { 'puppet': 
    ensure => running
  }
}

