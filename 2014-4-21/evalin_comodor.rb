#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
# **Usage** : 
# 
# * `ruby evalin_comodor.rb <accesstoken>`
# this will get a long term access token from the short term one
# * `ruby evalin_comodor.rb`
# will start the script
require './evalin.rb' # https://github.com/blazeeboy/RubyScripts/blob/master/2014-3-30/evalin.rb
require 'koala' # gem install koala

# create a facebook app and get access token from here
# https://developers.facebook.com/tools/explorer
# scopes required : 
# public_profile, basic_info, publish_checkins, status_update, photo_upload, video_upload, create_note, share_item, publish_stream, manage_notifications, publish_actions, user_friends

APP_ID      = 'xxxxxxxxxxxxxxxx'
APP_SECRET  = 'xxxxxxxxxxxxxxxx'
NOTIFICATIONS_LIMIT = 100

if ARGV.size > 0
  oauth = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET)
    new_access_info = oauth.exchange_access_token_info ARGV.first
    File.write 'token', new_access_info['access_token']
  puts 'New Access Token written'
  exit
end

# respond to comment with mention
def respond_to(graph, comment_id, post_id)

  comment = graph.get_object(comment_id)

  username = comment['from']['name']
  message = comment['message']
  puts "responding to : #{message}"

  # read comment parts languages and code
  groups = message.scan /#{$name}\s+([a-zA-Z+]+)(.+)/m
  return if groups.length != 1

  language = groups.first[0]
  code = groups.first[1].strip
  return unless output = evalin(code, language)

  # posting comment reply
  graph.put_object post_id, 'comments', {message: "#{username} \n#{output}"}

end

loop do
  begin
    # yes each time will read token
    # in case you started it then added access token
    # or refreshed it you won't need to restart it
    oauth_access_token = File.read('token')
    $graph = Koala::Facebook::API.new(oauth_access_token)

    # get your name
    $name = $graph.get_object('me')['name']

    # get notifications
    notifications = []
    page = $graph.get_connections('me','notifications')
    begin
      notifications += page
    end while page = page.next_page and notifications.length<=NOTIFICATIONS_LIMIT

    # 
    # Now lets head to parse and respond to them
    # 
    notifications.reverse_each do |n|
      begin
        if n['application'] and n['application']['name'] == 'Groups' and n['title'].include? 'mentioned you'

          ids = n['link'].scan /comment_id=([0-9]+)&/
          post_ids = n['link'].scan /permalink\/([0-9]+)\//
          if ids.size == 1 and post_ids.size == 1
            respond_to $graph, ids.first.first, post_ids.first.first 
          end

        end
      rescue 
        # ignore it
      end

      # mark notification as read
      $graph.put_object(n['id'],'', {unread: false})
    end
    puts "Notifications found : #{notifications.size}"

  # please rescue if something went wrong
  # thanks,
  rescue Exception => e
    puts "Error : #{e}"
  end

  # wait for 60 seconds and try again
  sleep 60
end