# == Class: puppet::master
#
# Class responsible for configuring the puppet master.
#
class puppet::master (
  $ensure         = true,
  $http_reporturl = undef,
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

  case $http_reporturl {
    undef: {
      $store_http = ''
    }
    default: {
      $store_http = ',http'

      augeas { 'puppetmaster-http-storeconfig':
        context => '/files/etc/puppet/puppet.conf',
        changes => [
          "set master/reporturl ${http_reporturl}",
        ],
      }
    }
  }

  case $storeconfig {
    activerecord: {
      augeas { 'puppetmaster-storeconfig-activerecord':
        context => '/files/etc/puppet/puppet.conf',
	changes => [
	  'set master/storeconfigs true',
	  "set master/dbadapter  ${db[adapter]}",
	  "set master/dbuser     '${db[user]}'",
	  "set master/dbpassword '${db[password]}'",
	  "set master/dbserver   '${db[server]}'",
	  "set master/dbname     '${db[name]}'"
	]
      }
    }
    puppetdb: {
      augeas { 'puppetmaster-storeconfig-augeas':
        context => '/files/etc/puppet/puppet.conf',
	changes => [
	  'set master/storeconfigs true',
	  "set master/storeconfigs_backend puppetdb"
	]
      }
    }
    default: {}
  }

  augeas { 'puppetmaster':
    context => '/files/etc/puppet/puppet.conf',
    changes => [
      "set master/reports store${store_http}",
    ],
  }

  service { 'puppetmaster':
    ensure  => running,
    enable  => true
  }

}

