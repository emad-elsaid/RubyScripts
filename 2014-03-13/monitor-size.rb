#!/usr/bin/env ruby

seconds_to_wait = 1*60*60 # 1 hour
$directories_to_watch = {
	'/Users/blaze/Desktop/folder1' => 1*1024, #bytes
	'/Users/blaze/Desktop/folder2' => 1*1024 #bytes
}

def alert_size_exceeded directory, size
	# you can replace this by an sending an email
	# or log it to a file
	puts "Alert: #{directory} exceeded size #{$directories_to_watch[directory]} and reached #{size}"
end

def dir_size directory
	# get this directory
	size = File.stat(directory).size

	Dir.open(directory).each do |file|
		unless ['.','..'].include? file
			path = "#{directory}/#{file}"

			if File.directory?  path
				size += dir_size path
			else
				size += File.stat(path).size
			end
		end
	end

	size
end

loop do
	$directories_to_watch.each do |directory, size|
		new_size = dir_size directory
		alert_size_exceeded directory, new_size if new_size>size
	end
	sleep seconds_to_wait
end