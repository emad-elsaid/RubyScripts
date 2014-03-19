#!/usr/bin/env ruby

# Credits to :
# http://stackoverflow.com/questions/16365553/creating-gist-from-a-ruby-script
# i modified the script alittle bit to read files from params
require 'net/http'
require 'json'


uri = URI("https://api.github.com/gists")

files = {}
ARGV.each do |f|
	files[f] = {
		content: File.read(f)
	}
end

payload = {
  'public' => true,
  'files' => files
}

req = Net::HTTP::Post.new(uri.path)
req.body = payload.to_json

puts req.inspect
puts req.body.inspect

# GitHub API is strictly via HTTPS, so SSL is mandatory
res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
  http.request(req)
end

response = JSON.parse res.body
puts response['html_url']