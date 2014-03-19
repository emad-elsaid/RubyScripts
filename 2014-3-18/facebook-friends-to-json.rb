#!/usr/bin/env ruby
require 'koala' # gem install koala --no-document
require 'json'
# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# select "user_friends" when authenticating
oauth_access_token = 'xxxxxxxxxxxxxxxx'

graph = Koala::Facebook::API.new(oauth_access_token)
fields = 'bio,name,birthday,first_name,last_name,gender,hometown,relationship_status,username,website,languages'

friends = []
# getting groups of interest
page = graph.get_connections("me", "friends/?fields=#{fields}")
begin
	friends += page
end while page = page.next_page

# write data to file as json
File.write 'friends.json', friends.to_json