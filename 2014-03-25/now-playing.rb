#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
# Idea of : Thibault (@EyeWriteCode)
require 'Twitter' #gem install twitter
begin
	# Create a read application from : 
	# https://apps.twitter.com
	# authenticate it for your account
	# fill in the following
	config = {
		consumer_key:        '',
		consumer_secret:     '',
		access_token:        '',
		access_token_secret: ''
	}
	sClient = Twitter::Streaming::Client.new(config)
	rClient = Twitter::REST::Client.new(config)
	following = rClient.friend_ids.to_a
	topics = ['#NP', '#NW', '#nowplaying', '#now_playing']

	sClient.filter(track: topics.join(',')) do |tweet|
		if tweet.is_a?(Twitter::Tweet)
		  text = tweet.text
		  			.gsub(/[#@]\S+/,'')
		  			.gsub(/\n+/,' ')
		  			.gsub(/\s{2,}/,'')
		  			.strip
		  user = tweet.user
		  puts "#{user.screen_name} : #{text}" if following.include? user.id
		end
	end
rescue
	puts 'error occurred, waiting for 5 seconds'
	sleep 5
	retry
end