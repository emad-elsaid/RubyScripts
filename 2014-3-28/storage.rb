#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'json'
require 'psych'
require 'commander/import' # gem install commander
program :version, '0.0.1'
program :description, 'Simple Key Value Storage Commandline Script'

FILENAME = 'storage.json'
storage = File.exists?(FILENAME) ? JSON.parse(File.read(FILENAME)) : {}

command :c do |c|
  c.syntax = 'storage c key value'
  c.description = 'create new key with a value in our storage'
  c.example 'store myname key with my name as a value', 'ruby storage c myname emad elsaid hamed'
  c.action do |args, options|
    storage[args[0]] = args[1..-1].join(' ')
    File.write FILENAME, storage.to_json
  end
end

command :r do |c|
  c.syntax = 'storage r key'
  c.description = 'read a key value or all values from storage'
  c.example 'read my name', 'ruby storage r myname'
  c.action do |args, options|
    puts( args[0] ? storage[args[0]] : storage.to_yaml )
  end
end

command :d do |c|
  c.syntax = 'storage d key'
  c.description = 'delete a key from storage'
  c.example 'remove my name from storage', 'ruby storage d myname'
  c.action do |args, options|
    storage.delete args[0]
    File.write FILENAME, storage.to_json
  end
end

