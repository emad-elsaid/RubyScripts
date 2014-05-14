#!/usr/bin/env ruby
require 'open-uri'
require 'json'

print 'Github Username: '
username = gets.chomp

# get gists
puts 'Downloading gists list'
gists_str = open("https://api.github.com/users/#{username}/gists").read
gists = JSON.parse gists_str

gists.each_with_index do |gist, index|

	puts "#{index+1}/#{gists.length} Downloading #{gist['url']}"
	gist_str = open(gist['url']).read
	gist = JSON.parse gist_str

	dir = gist["id"]
	Dir.mkdir dir unless Dir.exist? dir

	gist["files"].each do |file_name, file_value|
		File.open("#{dir}/#{file_name}", 'w') { |f| f.write file_value['content']}
	end

end
