#!/usr/bin/env ruby
require 'digest/md5'
require "addressable/uri"

# this is based on gravatar image API
# https://en.gravatar.com/site/implement/images/
# options :
# size : <integer> size of image
# default: <string> url of image if email not found or:
#  * 404
#  * mm
#  * identicon
#  * monsterid
#  * wavatar
#  * retro
#  * blank
# forcedefault: "y" force default image to load
# rating: <string> one of the values : g, pg, r, x
def gravatar email, *options
	email_md5 = Digest::MD5.hexdigest email
	unless options.empty?
		params = Addressable::URI.new
		params.query_values = options.first
		params_query = "?#{params.query}"
	end
	"http://www.gravatar.com/avatar/#{email_md5}#{params_query}"
end


puts gravatar('blazeeboy@gmail.com')
puts gravatar(
	'blazeeboy@gmail.com', 
	size: 200, 
	default: 'https://pbs.twimg.com/media/BheUcQMIAAA0Gns.jpg:large'
	)
