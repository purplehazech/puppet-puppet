# == Class: puppet::storeconfig
#
# install routes.yaml 
#
class puppet::storeconfig {

  file { '/etc/puppet/routes.yaml':
    content => template('puppet/routes.yaml.erb'),
    before  => Class['activerecord'],
    notify  => Service['puppetmaster']
  }
}
