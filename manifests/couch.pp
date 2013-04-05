# == Class: puppet::couch
#
# Installs the couchrest gem and a simple exec node terminus for grabbing
# data from the couch.
# 
class puppet::couch {
  package { 'couchrest':
    provider => 'gem'
  }
  
  file { '/etc/puppet/enc.rb':
    source => "puppet:///modules/puppet/couch-enc.rb"
  }
}