#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)

# it turns out that BBC website has a printable version of
# the top 40 UK singles chart, that made me jump of joy :D
require 'open-uri'

# get BBC singles chart printable version
page = open('http://www.bbc.co.uk/radio1/chart/singles/print').read
# result has data as table so we'll extract keys from TH tags
keys = page.scan(/<th>(.+)<\/th>/).map{ |k| k.first.downcase }
# extract cells from TD tags
cells = page.scan(/<td>(.*)<\/td>/).map{ |c| c.first }
# split cells to arrays each equal to keys
rows = cells.each_slice keys.size

# container to join data as Hash objects and push to it
data = []
# now iterate on each row and join keys with their
# respective values then convert them to arrays
rows.each do |row|
  data << Hash[ [keys, row].transpose ] # this is a good trick ;)
end

# show us what you got sir.
puts data
