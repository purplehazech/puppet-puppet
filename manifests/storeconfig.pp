# == Class: puppet::storeconfig
#
# install routes.yaml 
#
class puppet::storeconfig (
  $type = undef,
  $db   = {
    adapter  => 'mysql',
    user     => 'root',
    password => '',
    server   => 'localhost',
    name     => 'puppet',
  }
) {

  file { '/etc/puppet/routes.yaml':
    content => template('puppet/routes.yaml.erb'),
    notify  => Service['puppetmaster']
  }
  case $type {
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

}
