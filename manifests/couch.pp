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
  }
  
  file { '/etc/puppet/enc.rb':
    source => "puppet:///modules/puppet/couch-enc.rb"
  }
}