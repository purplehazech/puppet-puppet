# == Class: puppet::couch
#
# Installs the couchrest gem and a simple exec node terminus for grabbing
# data from the couch.
#
# === Parameters
# 
# [*url*]
#  full path to couch endpoint containg node definitions complete with auth info and everything.
# 
class puppet::couch (
  $url
) {

  package { 'couchrest':
    provider => 'gem'
  } -> file { '/etc/puppet/enc.rb':
    source => "puppet:///modules/puppet/couch-enc.rb",
    owner  => 'root',
    group  => 'puppet',
    mode   => '0555'
  } -> file { '/etc/puppet/enc.yaml':
    content => template('puppet/couch-enc.yaml.erb'),
    owner   => 'root',
    group   => 'puppet',
    mode    => '0550'
  } -> augeas { 'puppetmaster-couch-enc':
    context => '/files/etc/puppet/puppet.conf',
    changes => [
      'set master/node_terminus exec',
      'set master/external_nodes /etc/puppet/enc.rb',
    ],
  }

}
