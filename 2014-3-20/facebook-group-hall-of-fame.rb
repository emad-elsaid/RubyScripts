#!/usr/bin/env ruby
require 'koala' # gem install koala --no-document
require 'psych'
# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# select "user_groups" when authenticating
oauth_access_token = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
group_name = 'Egyptian Geeks'
posts_limit = 100
graph = Koala::Facebook::API.new(oauth_access_token)

# getting groups of interest
group = graph.get_connections('me', 'groups').find { |g| g['name']==group_name }
raise Exception.new 'Group Not found' unless group

# get posts
posts = []
page = graph.get_connections(group['id'],'feed')
begin
	posts += page
end while page = page.next_page and posts.length<=posts_limit

# generate analytics
analytics = posts.inject({}) do |mem, post|
	if mem.keys.include? post['from']['name']
		mem[post['from']['name']] += 1
	else
		mem[post['from']['name']] = 1
	end
	mem
end

# sort descending and convert each to key => value again
sorted = analytics.sort_by { |k,v| -v }.map {|k,v| {k => v}}
puts sorted.to_yaml