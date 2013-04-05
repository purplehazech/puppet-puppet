#!/usr/bin/ruby
require 'couchrest'
require 'yaml'

config = YAML.load_file('/etc/puppet/enc.yaml')

db = CouchRest.database! config.values_at('url').first

data = db.get(ARGV[0])

data['classes'].each do |key,puppetClass|
  data['classes'][key] = nil unless not puppetClass.empty?

  puppetClass.each do |valKey,valVal|
    data['classes'][key][valKey] = false unless valVal != "false"
    data['classes'][key][valKey] = true unless valVal != "true"
  end
end
data['parameters'].each do |key,param|
  data['parameters'][key] = false unless param != "false"
  data['parameters'][key] = true  unless param != "true"
end

node = {
  'environment' => data['environment'],
  'classes'     => data['classes'],
  'parameters'  => data['parameters']
}
puts node.to_yaml