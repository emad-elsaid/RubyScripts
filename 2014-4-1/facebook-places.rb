#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'koala' # gem install koala --no-document
# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# select "user_status", "friends_status", "user_checkins" when authenticating
oauth_access_token = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
graph = Koala::Facebook::API.new(oauth_access_token)

places = []
page = graph.get_connections('me', 'checkins')
begin
	places += page.map {|p| p['place']}
end while page = page.next_page

places.each do |place|
	unless place['location'].is_a? String
		puts "#{place['name']} lat:#{place['location']['latitude']} long:#{place['location']['longitude']}"
	else
		puts "#{place['name']} location:#{place['location']}"
	end
end