#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
require 'linkedin' # gem install linkedin
require 'json'

# create an appliation then
# get your api keys at https://www.linkedin.com/secure/developer
config = {
	your_consumer_key: 		'xxxxxxxxxxxxxxxx',
	your_consumer_secret: 	'xxxxxxxxxxxxxxxx',
	oauth_user_token: 		'xxxxxxxxxxxxxxxx',
	oauth_user_secret: 		'xxxxxxxxxxxxxxxx'
}
client = LinkedIn::Client.new(
						config[:your_consumer_key], 
						config[:your_consumer_secret] 
					)

client.authorize_from_access(
		config[:oauth_user_token],
		config[:oauth_user_secret]
	)

client.add_share(
	comment: 'Good Morning', 
	content: {'submitted-url' => 'http://www.github.com/blazeeboy' }
)