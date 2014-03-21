#!/usr/bin/env ruby
require 'koala' # gem install koala --no-document

# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# select "user_likes" when authenticating
oauth_access_token = 'xxxxxxxxxxxxxxxxxxxxxxxx'
graph = Koala::Facebook::API.new(oauth_access_token)

# get all likes
likes = []
page = graph.get_connections('me','likes')
begin
	likes += page
end while page = page.next_page


# print them all then print total likes
likes.each do |l|
	puts "#{l['name']} - http://www.facebook.com/#{l['id']} - #{l['created_time']}"
end
puts "Total likes : #{likes.length}"