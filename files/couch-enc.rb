#!/usr/bin/ruby
require 'couchrest'
require 'yaml'

db = CouchRest.database! ARGV[0]

data = db.get(ARGV[1])

data['classes'].each do |key,puppetClass|
  data['classes'][key] = nil unless not puppetClass.empty?
end

node = {
  'environment' => data['environment'],
  'classes'     => data['classes'],
  'parameters'  => data['parameters']
}
puts node.to_yaml