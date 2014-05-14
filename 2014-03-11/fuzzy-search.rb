#!/usr/bin/env ruby

# this is a simple fuzzy search algorithm
# similar to sublimeText and atom search 
# this search for insertion operations only
# amore complex one should search for replace
# delete and transpose as mentioned in 
# http://en.wikipedia.org/wiki/Fuzzy_string_searching
# also kudos to :
# http://www.quora.com/Algorithms/How-is-the-fuzzy-search-algorithm-in-Sublime-Text-designed

strings_to_query = [
	"/how_to/build/your/own/gems.rb",
	"How to build your google.rb own custom source control",
	"Public methods are your grub public API and be",
	"this text should be at the end"
]

query = 'grb'
query_reg = /#{query.split('').join('.*?')}/

sorted = []
strings_to_query.each do |string|
	match = query_reg.match string
	sorted << {string: string, rank: match.to_s.length} if match
end

sorted.sort_by! {|i| i[:rank] }

sorted.each do |pair|
	puts "#{pair[:rank]} : #{pair[:string]}"
end

# ublic methods are your grub public API and be
# How to build your google.rb own custom source control
# /how_to/build/your/own/gems.rb
# this text should be at the end
